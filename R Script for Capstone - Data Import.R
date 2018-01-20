#prevent warnings showing through
warnings=False
#read description of 1 test file
readLines(("UCASData/EOC_data_resource_2016-DR2_051_06.csv"), n = 3)
#create list of all files including extensions
allfiles <- list.files(path = "C:/Users/AnnaVaughan/Desktop/Capstone/Capstone/UCASData")
#create list of all filenames without extensions
allfilenames <- substr(allfiles,1,33)
#limit list to only csv file filenames
allcsvfilenames <- allfilenames [1:285]
#try out reading a single csv file
testimport <- read_csv("UCASData/EOC_data_resource_2016-DR2_001_01.csv", col_names = TRUE, skip = 5)
#after much trying out lapply and other functions, gave up and imported 3 files I knew were relevant
EOC_data_resource_2016_DR3_027_03 <- read_csv("UCASData/EOC_data_resource_2016-DR3_027_03.csv", col_names = TRUE, skip = 5)
EOC_data_resource_2016_DR3_018_03 <- read_csv("UCASData/EOC_data_resource_2016-DR3_018_03.csv", col_names = TRUE, skip = 5)
EOC_data_resource_2016_DR4_005_03 <- read_csv("UCASData/EOC_data_resource_2016-DR4_005_03.csv", col_names = TRUE, skip = 5)
