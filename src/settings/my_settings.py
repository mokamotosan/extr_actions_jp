Params = {
    "rawdata": {
        "root":
            "",
        "dir":
            "sampledata/",
        "file":
            "190226【人物評価に関する調査（ローデータ）】ご納品.xlsx",
        "sheet":
            "ローデータ"
    },
    "paths": {
        "current_root":
            "",
        "settings":
            "src/settings/",
        "text": {
            "proofed_text":
                "sampledata/results/texts/results03_cleanup/proofing/",
            "database":
                "sampledata/results/texts/results04_sqldatabase/",
            "fig_database":
                "sampledata/figures/texts/results04_sqldatabase/",
            "results_ca":
                "sampledata/results/texts/results05_ca/",
            "fig_ca":
                "sampledata/figures/texts/results05_ca/",
            "results_extracted":
                "sampledata/results/texts/results06_extracted/",
            "fig_extracted":
                "sampledata/figures/texts/results06_extracted/"
        },
        "rating": {
            "primary_convert":
                "sampledata/",
            "pca_results":
                "results/ratings/"
        },
        "psychpy": {
            "conditions":
                "src/psypy_verb_impression/conditions/"
        }
    },
    "files": {
        "proofed_text":
            "stage5_20190520T132156_20traits_proofed_誤字脱字修正_merged.txt",
        "database_text":
            "stage5_20190520T132156_20traits_proofed_誤字脱字修正_merged.sqlite",
        "rating":
            "rating.csv",
        "rating_ser":
            "reating_ser.csv",
        "pca_result":
            "pca_results_20190906T111104.xlsx"
    },
    "traitq": {
        "traitq01": "積極的な-消極的な",
        "traitq02": "人のわるい-人の良い",
        "traitq03": "生意気でない-生意気な",
        "traitq04": "人懐っこい-近づきがたい",
        "traitq05": "憎らしい-可愛らしい",
        "traitq06": "心の広い-心の狭い",
        "traitq07": "非社交的な-社交的な",
        "traitq08": "責任感のある-責任感のない",
        "traitq09": "軽率な-慎重な",
        "traitq10": "恥知らずの-恥ずかしがりの",
        "traitq11": "重厚な-軽薄な",
        "traitq12": "沈んだ-うきうきした",
        "traitq13": "堂々とした-卑屈な",
        "traitq14": "感じの悪い-感じの良い",
        "traitq15": "分別のある-無分別な",
        "traitq16": "親しみやすい-親しみにくい",
        "traitq17": "無気力な-意欲的な",
        "traitq18": "自信のない-自信のある",
        "traitq19": "気長な-短気な",
        "traitq20": "不親切な-親切な"
    },
    "extraction": {
        "dims":
            ["Dim1", "Dim2", "Dim3", "Dim4", "Dim5"],
        "th_stats":
            "contrib",
        "th_verbs":
            "50%",
        "th_traitq":
            "50%"
    }
}
