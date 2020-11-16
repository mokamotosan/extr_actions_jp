import sqlite3
import pandas as pd


def __extract_crosstable(fullpath_to_db):
    """[summary]

    Args:
        fullpath_to_db ([type]): [description]

    Returns:
        [type]: [description]
    """

    conn = sqlite3.connect(fullpath_to_db)
    dpnd_df = pd.read_sql_query("SELECT * FROM dpnd_datatable WHERE 親文節ID == -1", conn)
    conn.close()

    # drop NA: 20190809
    dpnd_df2 = dpnd_df.dropna(subset=["trait40"])
    # 20190808: 親正規化代表表記->親見出しに変更
    cross_df = pd.crosstab(dpnd_df["子見出し-親見出し"], dpnd_df2["trait40"])

    return cross_df


def create_datatable(fullpath_to_db):
    # create a data table for CA
    crosstable_df = __extract_crosstable(fullpath_to_db)
    print('Creating a data table for CA...done')
    
    # save the table
    conn = sqlite3.connect(fullpath_to_db)
    crosstable_df.to_sql("crosstable_predicate_traitq", conn,
                         if_exists="replace", index=True)
    conn.close()


def add_total(fullpath_to_db):
    # read a data table for CA
    conn = sqlite3.connect(fullpath_to_db)
    cross_df = pd.read_sql_query("SELECT * FROM crosstable_predicate_traitq", conn)
    conn.close()
    
    # sum in each row
    cross_df["total_count"] = cross_df.sum(axis="columns")

    # save the table
    conn = sqlite3.connect(fullpath_to_db)
    cross_df.to_sql("crosstable_predicate_traitq_total", conn,
                    if_exists="replace", index=False)
    conn.close()
