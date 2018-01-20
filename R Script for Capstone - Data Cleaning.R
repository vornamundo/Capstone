#prevent warnings showing through
warnings=False
#rename files to show their content
EOC_data_resource_2016_DR4_005_03_Provider_Domicile <- EOC_data_resource_2016_DR4_005_03
EOC_data_resource_2016_DR3_027_03_Subject_Domicile <- EOC_data_resource_2016_DR3_027_03
EOC_data_resource_2016_DR3_018_03_Subject_Age <- EOC_data_resource_2016_DR3_018_03
#view summary of files
summary(EOC_data_resource_2016_DR3_018_03_Subject_Age)
summary(EOC_data_resource_2016_DR3_027_03_Subject_Domicile)
summary(EOC_data_resource_2016_DR4_005_03_Provider_Domicile)
#remove blank columns from files and rename
Provider_Domicile_EOC_data_resource_2016_DR4_005_03 <- select(EOC_data_resource_2016_DR4_005_03_Provider_Domicile, -X5)
Subject_Age_EOC_data_resource_2016_DR3_018_03 <- select(EOC_data_resource_2016_DR3_018_03_Subject_Age, -X5)
Subject_Domicile_EOC_data_resource_2016_DR3_027_03 <- select(EOC_data_resource_2016_DR3_027_03_Subject_Domicile, -X5)
#check new files for NA values
any(is.na(Provider_Domicile_EOC_data_resource_2016_DR4_005_03))
any(is.na(Subject_Age_EOC_data_resource_2016_DR3_018_03))
any(is.na(Subject_Domicile_EOC_data_resource_2016_DR3_027_03))
#view summary of subject and age file to see columns included
summary(Subject_Age_EOC_data_resource_2016_DR3_018_03)
#check values by column to see whether any values that don't make sense or are outliers
unique(Subject_Age_EOC_data_resource_2016_DR3_018_03$`Age Band`)
unique(Subject_Age_EOC_data_resource_2016_DR3_018_03$`Subject Group (Detailed Level)`)
unique(Subject_Age_EOC_data_resource_2016_DR3_018_03$`Cycle Year`)
unique(Subject_Age_EOC_data_resource_2016_DR3_018_03$`Number of Applications`)
#view summary of subject and domicile file to see columns included
summary(Subject_Domicile_EOC_data_resource_2016_DR3_027_03)
#check values by column to see whether any values that don't make sense or are outliers
unique(Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Cycle Year`)
unique(Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Subject Group (Detailed Level)`)
unique(Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Applicant Domicile (Region)`)
#summary shows 'Unknown' as a category in Applicant Domicile, so check how many
summary(Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Applicant Domicile (Region)` == "'Unknown'")
#view summary of subject and domicile file to see columns included
summary(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)
#check values by column to see whether any values that don't make sense or are outliers
unique(Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Cycle Year`)
unique(Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Provider Name`)
unique(Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Applicant Domicile (Region)`)
unique(Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Number of Applications`)
#summary shows 'Unknown' as a category in Applicant Domicile, so check how many
summary(Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Applicant Domicile (Region)` == "'Unknown'")
#view summary to check whether any titles or text needs further tidying
summary(Subject_Age_EOC_data_resource_2016_DR3_018_03)
#replace single quotes for fields where entries are all surrounded by them with nothing, viewing to check replacement has worked
Subject_Age_EOC_data_resource_2016_DR3_018_03$`Subject Group (Detailed Level)` <- gsub(pattern = "'", replacement = "", x = Subject_Age_EOC_data_resource_2016_DR3_018_03$`Subject Group (Detailed Level)`)
Subject_Age_EOC_data_resource_2016_DR3_018_03$`Age Band` <- gsub(pattern = "'", replacement = "", x = Subject_Age_EOC_data_resource_2016_DR3_018_03$`Age Band`)
Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Subject Group (Detailed Level)` <- gsub(pattern = "'", replacement = "", x = Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Subject Group (Detailed Level)`)
Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Applicant Domicile (Region)` <- gsub(pattern = "'", replacement = "", x = Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Applicant Domicile (Region)`)
Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Provider Name`<- gsub(pattern = "'", replacement = "", x = Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Provider Name`)
Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Applicant Domicile (Region)` <- gsub(pattern = "'", replacement = "", x = Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Applicant Domicile (Region)`)
#require 2016 data only for initial analysis, so check data class of that column
class(Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Cycle Year`)
#create data subset for subject by domicile only containing 2016 data
Subject_Domicile_2016 <- subset(Subject_Domicile_EOC_data_resource_2016_DR3_027_03, Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Cycle Year` == 2016)
#rename columns to make them more meaningful, ahead of selecting and subsetting
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Cycle Year'] <- 'cycle_year'
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Provider Name'] <- 'provider_name'
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Applicant Domicile (Region)'] <- 'applicant_domicile_(region)'
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Number of Applications'] <- 'number_of_applications'

