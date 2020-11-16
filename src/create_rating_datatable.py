# from my_settings import Params
import pandas as pd
import numpy as np


def create_primary_table(Params):
    rawdata_path = Params["rawdata"]["root"] + Params["rawdata"]["dir"]
    rawdata_name = Params["rawdata"]["file"]
    rawdata_sheet = Params["rawdata"]["sheet"]
    raw_df = pd.read_excel(rawdata_path + rawdata_name,
                           sheet_name=rawdata_sheet)
    rating_df = raw_df.loc[:, raw_df.columns.str.endswith("_1s1")]
    rating_df.columns = Params["traitq"].values()

    rating_path\
        = Params["paths"]["current_root"]\
        + Params["paths"]["rating"]["primary_convert"]
    rating_name = Params["files"]["rating"]
    rating_df.to_csv(rating_path + rating_name)


def create_trait40_table(Params):
    # load data
    rating_path\
        = Params["paths"]["current_root"]\
        + Params["paths"]["rating"]["primary_convert"]
    rating_name = Params["files"]["rating"]
    rating_df = pd.read_csv(rating_path + rating_name, index_col=0)
    # serialize
    rating_array = rating_df.values
    n_elements = rating_array.size
    rating_array = np.reshape(rating_array, (n_elements, -1), order="A")
    trait40_df = pd.DataFrame(data=rating_array, columns=["rating"])
    # add labels for trait20 ID
    trait20 = []
    n_samples = 1600
    [trait20.extend([col_name] * n_samples) for col_name in rating_df.columns]
    trait40_df["trait20"] = trait20
    # add lables for trait40 ID
    trait40 = []
    for row in trait40_df.values:
        score = row[0]
        trait2 = row[1].split("-")
        if score <= 2:
            trait40.append(trait2[0])
        elif score >= 6:
            trait40.append(trait2[1])
        else:
            trait40.append("")
    trait40_df["trait40"] = trait40
    # save
    trait40_df.to_csv(rating_path + Params["files"]["rating_ser"],
                      header=True, index=True)
