from settings.my_settings import Params
import os
import datetime
import pandas as pd
import sqlite3
from logging import basicConfig, getLogger
from logging import StreamHandler, Formatter, DEBUG, ERROR

# logfile格納用フォルダの作成
log_dir = "logfiles"
try:
    os.mkdir(log_dir)
except FileExistsError:
    pass
# Fullpath to the logfile
log_path = os.path.dirname(os.path.abspath(__file__))
# logfile名
script_name = os.path.basename(__file__)
datetime_str = datetime.datetime.today().strftime("%Y%m%d%H%M")
log_name = script_name.split(".")[0] + datetime_str + ".log"
# logfileの設定
basicConfig(filename=os.path.join(log_path, log_dir, log_name))
# loggerオブジェクトの宣言
logger = getLogger(__name__)
# loggerのログレベル（ハンドラに渡すログレベル）
logger.setLevel(DEBUG)
# handlerの生成
stream_handler = StreamHandler()
# handlerのログレベル（ハンドラが出力するログレベル)
stream_handler.setLevel(ERROR)
# ログ出力フォーマットの作成
handler_format\
    = Formatter('%(action)s - %(name)s - %(levelname)s -%(message)s')
# ログ出力フォーマットの設定
stream_handler.setFormatter(handler_format)
# loggerにhandlerをセット
logger.addHandler(stream_handler)


def __extract_traitq_id(line):
    """
    traitq ID　の抽出
    :param line: in str
    :return: traitqID: in str, s.t. "積極的な―消極的な"
    """
    begin = len("<H1>")
    end = line.find("</H1>")
    return Params["traitq"][line[begin: end]]


def __parse_bnst(line):
    """
    文節の格解析
    :param line: in str
    :return: bnst_list from pyknp
    """
    import pyknp
    # 詳細な分析結果の表示；照応解析あり
    knp = pyknp.KNP(option="-tab -anaphora")
    # 空白，タブの除去
    line2 = "".join(line.split())
    # 以下，文章を切り詰める応急処置．
    # TODO: 全文を解析できるように対応する必要あり．
    # 全角ピリオドを句点に置換後，右から区切る
    line2_list = line2.replace("．", "。").rsplit("。", 0)
    n = 1
    while len(line2_list[0]) >= 218:
        # 全角ピリオドを句点に置換後，右から区切る
        line2_list = line2.replace("．", "。").rsplit("。", n)
        n += 1
    results = knp.parse(line2_list[0])
    return results.bnst_list()


def __extract_normalized_representative_notation(fstring):
    """正規化代表表記の抽出
    """
    begin = fstring.find("<正規化代表表記:")
    end = fstring.find("/", begin + 1)
    return fstring[begin + len("<正規化代表表記:"): end]


def __extract_bnst_info(bnst_list):
    """
    一行分の文節情報の取得
    :param bnst_list: from pyknp
    :return: dictionary with keys ["文節ID", "見出し", "正規化代表表記", "係り受けタイプ", "親文節ID", "素性"]
    """
    dic = {"文節ID": [], "見出し": [], "正規化代表表記": [], "係り受けタイプ": [], "親文節ID": [], "素性": []}
    for bnst in bnst_list:
        dic["文節ID"].append(bnst.bnst_id)
        dic["見出し"].append("".join(mrph.midasi for mrph in bnst.mrph_list()))
        dic["正規化代表表記"].append(__extract_normalized_representative_notation(bnst.fstring))
        dic["係り受けタイプ"].append(bnst.dpndtype)
        dic["親文節ID"].append(bnst.parent_id)
        dic["素性"].append(bnst.fstring)

    return dic


def __create_bnst_df(line_list):
    """
    複数行の文節情報をまとめたディクショナリの作成
    :param line_list:
    :return bnst_dic: dictionary with keys ["lineID", "traitqID", "文節ID", "見出し", "正規化代表表記", "係り受けタイプ", "親文節ID", "素性"]
    """

    from tqdm import tqdm
    with tqdm(total=len(line_list)) as pbar:

        dic = {"lineID": [], "traitqID": [], "文節ID": [], "見出し": [], "正規化代表表記": [], "係り受けタイプ": [], "親文節ID": [], "素性": []}
        description_id = 0
        for line_count, line in enumerate(line_list):
            if line.startswith("<H1>"):
                traitq_id = __extract_traitq_id(line)
            else:
                description_id += 1
                try:
                    bnst_list = __parse_bnst(line)
                    bnst_dic = __extract_bnst_info(bnst_list)
                except:  # TODO: ログファイルに｛実行日時｝と｛エラー内容｝を記述させる
                    logger.error("encountered at line {}".format(line_count + 1))
                    continue

                num_bnst = len(bnst_list)
                dic["lineID"].extend([description_id] * num_bnst)
                dic["traitqID"].extend([traitq_id] * num_bnst)
                dic["文節ID"].extend(bnst_dic["文節ID"])
                dic["見出し"].extend(bnst_dic["見出し"])
                dic["正規化代表表記"].extend(bnst_dic["正規化代表表記"])
                dic["係り受けタイプ"].extend(bnst_dic["係り受けタイプ"])
                dic["親文節ID"].extend(bnst_dic["親文節ID"])
                dic["素性"].extend(bnst_dic["素性"])

            pbar.update(1)

    type(dic)
    return pd.DataFrame(dic)


def create_datatable(filename, dbname, encode):

    """encoding:
        "utf-8-sig": for UTF-u with BOM
        "cp932": for windows
    """
    fid = open(filename, "r", encoding=encode)
    line_list = fid.readlines()  # Read the first line
    fid.close()

    bnst_df = __create_bnst_df(line_list)

    conn = sqlite3.connect(dbname)
    bnst_df.to_sql("bnst_datatable", conn, if_exists="replace", index=False)
    conn.close()


def add_trait20_40(fullpath_to_rating, fullpath_to_db):
    # # set paths
    # project_path = Params["paths"]["current_root"]
    # db_path = Params["paths"]["text"]["database"]
    # db_name = Params["files"]["database_text"]
    # fullpath_to_db = project_path + db_path + db_name
    # rating_path\
    #     = Params["paths"]["current_root"]\
    #     + Params["paths"]["rating"]["primary_convert"]
    # rating_name = Params["files"]["rating_ser"]
    # fullpath_to_rating = rating_path + rating_name
    # load rating data
    rating_df = pd.read_csv(fullpath_to_rating, index_col=0)
    rating_df["lineID"] = list(range(1, len(rating_df) + 1))
    # laod bnst data
    conn = sqlite3.connect(fullpath_to_db)
    bnst_df = pd.read_sql_query("SELECT * FROM bnst_datatable", conn)
    conn.close()
    # join the tables
    df = pd.merge(rating_df, bnst_df, on="lineID")
    # save the table
    conn = sqlite3.connect(fullpath_to_db)
    df.to_sql("bnst_datatable", conn, if_exists="replace", index=False)
    conn.close()
