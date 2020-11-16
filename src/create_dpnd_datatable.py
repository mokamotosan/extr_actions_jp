import sqlite3
import pandas as pd


def __extract_dpnd(predicate_bnst_id, bnst_df):
    """
    格要素と述語の係り受け構造の抽出
    :param predicate_bnst_id:
    :param bnst_df: only rows with line_id matching to predicate_bnst
    :return:
    """
    df = bnst_df.loc[(bnst_df["親文節ID"] == predicate_bnst_id)]

    child_midasi_list = df["見出し"].tolist()
    if len(child_midasi_list) == 0:
        child_midasi_list = [""]

    from_bnst_list = df["文節ID"].tolist()
    if len(from_bnst_list) == 0:
        from_bnst_list = [""]

    return child_midasi_list, from_bnst_list


def __create_dpnd_df(predicate_df, bnst_df):
    """
    格要素と述語の係り受けデータの作成
    :param predicate_df:DataFrame with columns ["rating", "trait20", "trait40", "lineID", "traitqID", "文節ID", "見出し", "正規化代表表記", "係り受けタイプ", "親文節ID", "素性"]
    :param bnst_df: DataFrame with columns ["rating", "trait20", "trait40", "lineID", "traitqID", "文節ID", "見出し", "正規化代表表記", "係り受けタイプ", "親文節ID", "素性"]
    :return dpnd_df: DataFrame with columns ["lineID", "traitqID", "子見出し", "親見出し", "親正規化代表表記", "子見出し-親正規化代表表記", "from文節ID", "to文節ID", "親文節ID"]
    """
    dic = {"lineID": [], "traitqID": [], "trait20": [], "trait40": [], "rating": [], "子見出し": [], "親見出し": [], "親正規化代表表記": [], "子見出し-親見出し": [], "from文節ID": [], "to文節ID": [], "親文節ID": []}
    for row_tpl in predicate_df.itertuples():

        child_midasi_list, from_bnst_list = __extract_dpnd(row_tpl[6], bnst_df.loc[bnst_df["lineID"] == row_tpl[4]])  # the row_tpl begins with a row index
        num_dpnd = len(child_midasi_list)

        dic["trait20"].extend([row_tpl[2]] * num_dpnd)
        dic["trait40"].extend([row_tpl[3]] * num_dpnd)
        dic["rating"].extend([row_tpl[1]] * num_dpnd)
        dic["lineID"].extend([row_tpl[4]] * num_dpnd)
        dic["traitqID"].extend([row_tpl[5]] * num_dpnd)
        dic["子見出し"].extend(child_midasi_list)
        dic["親見出し"].extend([row_tpl[7]] * num_dpnd)
        dic["親正規化代表表記"].extend([row_tpl[8]] * num_dpnd)
        # 20190808: 親正規化代表表記->親見出しに変更
        dic["子見出し-親見出し"].extend([child_midasi + row_tpl[7].replace("。", "") for child_midasi in child_midasi_list])
        dic["from文節ID"].extend(from_bnst_list)
        dic["to文節ID"].extend([row_tpl[6]] * num_dpnd)
        dic["親文節ID"].extend([row_tpl[10]] * num_dpnd)

    return pd.DataFrame(dic)


def create_datatable(dbname):
    conn = sqlite3.connect(dbname)
    bnst_df = pd.read_sql_query("SELECT * FROM bnst_datatable", conn)
    predicate_df = pd.read_sql_query("SELECT * FROM predicate_datatable", conn)
    conn.close()

    dpnd_df = __create_dpnd_df(predicate_df, bnst_df)

    conn = sqlite3.connect(dbname)
    dpnd_df.to_sql("dpnd_datatable", conn, if_exists="replace", index=False)
    conn.close()
