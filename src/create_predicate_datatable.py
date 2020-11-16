import sqlite3
import pandas as pd


def __select_predicate(bnst_df):
    """
    述語文節の抽出
    :param bnst_df:
    :return: pandas DataFrame
    """
    return bnst_df[bnst_df["素性"].map(
        lambda fstring: fstring.find("<用言:動>")) != -1]


def create_datatable(dbname):
    conn = sqlite3.connect(dbname)
    bnst_df = pd.read_sql_query("SELECT * FROM bnst_datatable", conn)
    conn.close()

    predicate_df = __select_predicate(bnst_df)

    conn = sqlite3.connect(dbname)
    predicate_df.to_sql(
        "predicate_datatable", conn, if_exists="replace", index=False)
    conn.close()
