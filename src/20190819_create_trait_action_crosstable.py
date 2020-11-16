from settings.my_settings import Params
import create_rating_datatable
import create_bnst_datatable
import create_predicate_datatable
import create_dpnd_datatable
import create_crosstable

if __name__ == "__main__":
    # create bnst data table

    # set paths
    project_path = Params["paths"]["current_root"]
    proofed_path = Params["paths"]["text"]["proofed_text"]
    db_path = Params["paths"]["text"]["database"]
    # set file names and encoding
    proofed_name = Params["files"]["proofed_text"]
    db_name = Params["files"]["database_text"]
    encode = "cp932"
    # for test data
    # filename = "test.txt" # for test
    # db_name = "test.sqlite" # for test
    # encode = "utf-8-sig"

    fullpath_to_text = project_path + proofed_path + proofed_name
    fullpath_to_db = project_path + db_path + db_name

    # create data tables for rating data
    create_rating_datatable.create_primary_table(Params)
    create_rating_datatable.create_trait40_table(Params)

    # create bnst data table
    create_bnst_datatable.create_datatable(
        fullpath_to_text, fullpath_to_db, encode)
    
    # add trait20 and trait40
    rating_path\
        = Params["paths"]["current_root"]\
        + Params["paths"]["rating"]["primary_convert"]
    rating_name = Params["files"]["rating_ser"]
    fullpath_to_rating = rating_path + rating_name
    create_bnst_datatable.add_trait20_40(fullpath_to_rating,
                                         fullpath_to_db)

    # create predicate data table
    create_predicate_datatable.create_datatable(fullpath_to_db)

    # create dpnd data table
    create_dpnd_datatable.create_datatable(fullpath_to_db)

    # create crosstable (traitq x predicate)
    create_crosstable.create_datatable(fullpath_to_db)

    # create crosstable (traitq x predicate)
    create_crosstable.add_total(fullpath_to_db)
