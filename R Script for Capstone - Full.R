#prepare packages needed
install.packages("tidyverse")
library(readr)
library(dplyr)
#check and set working directory
getwd()
setwd("C:/Users/AnnaVaughan/Desktop")
#read description of 1 test file
readLines(("UCASData/EOC_data_resource_2016-DR2_051_06.csv"), n = 3)
#create list of all files including extensions
allfiles <- list.files(path = "C:/Users/AnnaVaughan/Desktop/UCASData")
#create list of all filenames without extensions
allfilenames <- substr(allfiles,1,33)
#limit list to only csv file filenames
allcsvfilenames <- allfilenames [1:285]
#try out reading a single csv file
testimport <- read_csv("UCASData/EOC_data_resource_2016-DR2_001_01.csv", col_names = TRUE, skip = 5)
#try importing file and creating filename for 1 file
names <-substr(filenames,1,33)EOC_data_resource_2016_DR3_027_03 <- read_csv("UCASData/EOC_data_resource_2016-DR3_027_03.csv", col_names = TRUE, skip = 5)
#after much trying out lapply and other functions, gave up and imported 3 files I knew were relevant
EOC_data_resource_2016_DR3_027_03 <- read_csv("UCASData/EOC_data_resource_2016-DR3_027_03.csv", col_names = TRUE, skip = 5)
View(EOC_data_resource_2016_DR3_027_03)  
EOC_data_resource_2016_DR3_018_03 <- read_csv("UCASData/EOC_data_resource_2016-DR3_018_03.csv", col_names = TRUE, skip = 5)
EOC_data_resource_2016_DR4_005_03 <- read_csv("UCASData/EOC_data_resource_2016-DR4_005_03.csv", col_names = TRUE, skip = 5)
#view files to check they had imported correctly
View(EOC_data_resource_2016_DR3_027_03)
View(EOC_data_resource_2016_DR3_018_03)
View(EOC_data_resource_2016_DR4_005_03)
#rename files to show their content
EOC_data_resource_2016_DR4_005_03_Provider_Domicile <- EOC_data_resource_2016_DR4_005_03
EOC_data_resource_2016_DR3_027_03_Subject_Domicile <- EOC_data_resource_2016_DR3_027_03
EOC_data_resource_2016_DR3_018_03_Subject_Age <- EOC_data_resource_2016_DR3_018_03
#view files to check rename had worked
View(EOC_data_resource_2016_DR4_005_03_Provider_Domicile)
View(EOC_data_resource_2016_DR3_027_03_Subject_Domicile)
View(EOC_data_resource_2016_DR3_018_03_Subject_Age)
#view summary of files
summary(EOC_data_resource_2016_DR3_018_03_Subject_Age)
summary(EOC_data_resource_2016_DR3_027_03_Subject_Domicile)
summary(EOC_data_resource_2016_DR4_005_03_Provider_Domicile)
#remove blank columns from files and rename
Provider_Domicile_EOC_data_resource_2016_DR4_005_03 <- select(EOC_data_resource_2016_DR4_005_03_Provider_Domicile, -X5)
View(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)
Subject_Age_EOC_data_resource_2016_DR3_018_03 <- select(EOC_data_resource_2016_DR3_018_03_Subject_Age, -X5)
Subject_Domicile_EOC_data_resource_2016_DR3_027_03 <- select(EOC_data_resource_2016_DR3_027_03_Subject_Domicile, -X5)
View(Subject_Domicile_EOC_data_resource_2016_DR3_027_03)
#check new files for NA values
any(is.na(Provider_Domicile_EOC_data_resource_2016_DR4_005_03))
any(is.na(Subject_Age_EOC_data_resource_2016_DR3_018_03))
any(is.na(Subject_Domicile_EOC_data_resource_2016_DR3_027_03))
#view new files
View(Subject_Age_EOC_data_resource_2016_DR3_018_03)
View(Subject_Domicile_EOC_data_resource_2016_DR3_027_03)
View(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)
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
View(Subject_Age_EOC_data_resource_2016_DR3_018_03)
Subject_Age_EOC_data_resource_2016_DR3_018_03$`Age Band` <- gsub(pattern = "'", replacement = "", x = Subject_Age_EOC_data_resource_2016_DR3_018_03$`Age Band`)
View(Subject_Age_EOC_data_resource_2016_DR3_018_03)
Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Subject Group (Detailed Level)` <- gsub(pattern = "'", replacement = "", x = Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Subject Group (Detailed Level)`)
View(Subject_Domicile_EOC_data_resource_2016_DR3_027_03)
Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Applicant Domicile (Region)` <- gsub(pattern = "'", replacement = "", x = Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Applicant Domicile (Region)`)
View(Subject_Domicile_EOC_data_resource_2016_DR3_027_03)
Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Provider Name`<- gsub(pattern = "'", replacement = "", x = Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Provider Name`)
View(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)
Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Applicant Domicile (Region)` <- gsub(pattern = "'", replacement = "", x = Provider_Domicile_EOC_data_resource_2016_DR4_005_03$`Applicant Domicile (Region)`)
View(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)
#require 2016 data only for initial analysis, so check data class of that column
class(Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Cycle Year`)
#create data subset for subject by domicile only containing 2016 data
Subject_Domicile_2016 <- subset(Subject_Domicile_EOC_data_resource_2016_DR3_027_03, Subject_Domicile_EOC_data_resource_2016_DR3_027_03$`Cycle Year` == 2016)
#check subset has been created correctly
View (Subject_Domicile_2016)
#load ggplot2 to create plots
library(ggplot2)
#rename columns to make them more meaningful, ahead of selecting and subsetting
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Cycle Year'] <- 'cycle_year'
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Provider Name'] <- 'provider_name'
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Applicant Domicile (Region)'] <- 'applicant_domicile_(region)'
names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03)[names(Provider_Domicile_EOC_data_resource_2016_DR4_005_03) == 'Number of Applications'] <- 'number_of_applications'
#create reduced dataframe to compare overall student numbers for MMU and Salford
#remove regions column and check outcome
MMU_Salf_App_Numbers_1 <- select(Provider_Domicile_EOC_data_resource_2016_DR4_005_03, "cycle_year", "provider_name", "number_of_applications")
View(MMU_Salf_App_Numbers_1)
#group by cycle year and provider name, and summarise number of applications, and check outcome
MMU_Salf_App_Numbers_2 <- MMU_Salf_App_Numbers_1 %>% group_by(cycle_year, provider_name) %>% summarise(number_of_applications = sum(number_of_applications))
View(MMU_Salf_App_Numbers_2)
#remove all other providers than MMU and Salford, and check outcome
MMU_Salf_App_Numbers_3 <- filter(MMU_Salf_App_Numbers_2, provider_name %in% c("M40 The Manchester Metropolitan University", "S03 The University of Salford"))
View(MMU_Salf_App_Numbers_3)
#arrange in provider order, and check outcome
MMU_Salf_App_Numbers_4 <- arrange(MMU_Salf_App_Numbers_3, provider_name, cycle_year)
View(MMU_Salf_App_Numbers_4)
#load tidyr
library(tidyr)
#spread year values in cycle year columns into their own columns, and check outcome
MMU_Salf_App_Numbers_5 <- spread(MMU_Salf_App_Numbers_4, cycle_year, number_of_applications)
View(MMU_Salf_App_Numbers_5)
#ensure dplyr is loaded
library(dplyr)
#spread provider names in provider name columns into their own columns instead, and check outcome
MMU_Salf_App_Numbers_6 <- spread(MMU_Salf_App_Numbers_4, provider_name, number_of_applications)
View(MMU_Salf_App_Numbers_6)
#sum the total 
sum(MMU_Salf_App_Numbers_6$`M40 The Manchester Metropolitan University`)
sum(MMU_Salf_App_Numbers_6$`S03 The University of Salford`)
#plot scatter plot of application numbers to each institution over time
ggplot(MMU_Salf_App_Numbers_4, aes(x = cycle_year, y = number_of_applications, col = provider_name)) + geom_point() + geom_smooth(lwd = 2, se = FALSE)
#tidy up column names in MMU_Salf_App_Numbers_6 by adding underscore, and check outcome
names(MMU_Salf_App_Numbers_6) <- gsub(" ", ".", names(MMU_Salf_App_Numbers_6))
str(MMU_Salf_App_Numbers_6)
#create column showing total applications by year for the two institutions combined, and check outcome
MMU_Salf_App_Numbers_7 <- MMU_Salf_App_Numbers_6 %>% mutate(total = M40.The.Manchester.Metropolitan.University + S03.The.University.of.Salford)
View(MMU_Salf_App_Numbers_7)
#calculate percentage of two institutions' combined applications received by each institution, per year, and check outcome
MMU_Salf_App_Numbers_8 <- MMU_Salf_App_Numbers_7 %>% mutate(MMU_percentage = M40.The.Manchester.Metropolitan.University/total, UoS_percentage = S03.The.University.of.Salford/total)
View(MMU_Salf_App_Numbers_8)
#when trying to gather institution name columns into one, cycle.year wasn't recognised, so lookedup up fix on stackoverflow
MMU_Salf_App_Numbers_8 <- as.data.frame(MMU_Salf_App_Numbers_8)
#gathered HE institution names to reshape data
MMU_Salf_App_Numbers_9 <- gather(MMU_Salf_App_Numbers_8, "HE_institution", "n", 2:3)
View(MMU_Salf_App_Numbers_9)
#selected only relevant value for percentages to create new table
MMU_Salf_App_Numbers_10 <- select(MMU_Salf_App_Numbers_9, cycle_year, MMU_percentage, UoS_percentage, HE_institution)
View(MMU_Salf_App_Numbers_10)
#create two tables, one for each institution, to separate out percentages and then combine again
MMU_only_percentage <- filter(MMU_Salf_App_Numbers_10, HE_institution %in%  "M40.The.Manchester.Metropolitan.University")
UoS_only_percentage <- filter(MMU_Salf_App_Numbers_10, HE_institution %in% "S03.The.University.of.Salford")
View(MMU_only_percentage)
#realise redundant percentage column now needs removing from each of these
MMU_only_percentage <- select(MMU_only_percentage, cycle_year, MMU_percentage, HE_institution)
View(MMU_only_percentage)
UoS_only_percentage <- select(UoS_only_percentage, cycle_year, UoS_percentage, HE_institution)
#need to rename percentage columns in each so they match ahead of the join, and couldn't seem to make rename work
MMU_only_percentage <- mutate(MMU_only_percentage, percentage = MMU_percentage)
UoS_only_percentage <- mutate(UoS_only_percentage, percentage = UoS_percentage)
#remove non-matching columns showing percentages
MMU_only_percentage <- select(MMU_only_percentage, cycle_year, HE_institution, percentage)
UoS_only_percentage <- select(UoS_only_percentage, cycle_year, HE_institution, percentage)
#combine the two dataframes back together
MMU_Salf_App_Numbers_11 <- bind_rows(UoS_only_percentage, MMU_only_percentage)
View(MMU_Salf_App_Numbers_11)
#plot bar chart to see how percentage of applications varies over time
ggplot(MMU_Salf_App_Numbers_11, aes(x = cycle_year, y = percentage, fill = HE_institution)) + geom_bar(stat = "identity") + geom_smooth()
#import provider by subject data
EOC_data_resource_2016_DR4_016_03 <- read_csv("UCASData/EOC_data_resource_2016-DR4_016_03.csv", col_names = TRUE, skip = 5)
#clarify name of the file to make it easier to work with
EOC_data_resource_2016_DR4_016_03_Provider_Subject <- EOC_data_resource_2016_DR4_016_03
#view file to check rename had worked
View(EOC_data_resource_2016_DR4_016_03_Provider_Subject)
#view summary of file
summary(EOC_data_resource_2016_DR4_016_03_Provider_Subject)
#remove blank columns from file and rename, and view to check
Provider_Subject_EOC_data_resource_2016_DR4_016_03 <- select(EOC_data_resource_2016_DR4_016_03_Provider_Subject, -X5)
View(Provider_Subject_EOC_data_resource_2016_DR4_016_03)
#summarise by year and subject only, removing provider, and view to check
Subject_Group_By_Year_Summary <- Provider_Subject_EOC_data_resource_2016_DR4_016_03 %>% group_by(`Cycle Year`, `Subject Group (Summary Level)` ) %>% summarise(sum = sum(`Number of Applications`))
View(Subject_Group_By_Year_Summary)
#create file only containing applications by subject for 2016 overall (to allow non-time series comparison with MMU and UoS)
Subject_Group_2016_Summary <- filter(Subject_Group_By_Year_Summary, `Cycle Year` == 2016)
View(Subject_Group_2016_Summary)
#remove ` marks from data in key columns in provider subject document
Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Provider Name` <- gsub(pattern = "'", replacement = "", x = Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Provider Name`)
View(Provider_Subject_EOC_data_resource_2016_DR4_016_03)
Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Subject Group (Summary Level)` <- gsub(pattern = "'", replacement = "", x = Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Subject Group (Summary Level)`)
View(Provider_Subject_EOC_data_resource_2016_DR4_016_03)
#create summary of subject and year just for MMU and UoS
Subject_Group_By_Year_MMU_UoS_Summary <- Provider_Subject_EOC_data_resource_2016_DR4_016_03 %>% filter(`Provider Name` %in% c("M40 The Manchester Metropolitan University", "S03 The University of Salford"))
View(Subject_Group_By_Year_MMU_UoS_Summary)
#filter summary of subject and year just for MMU and UoS down to just 2016
Subject_Group_2016_MMU_UoS_Summary <- filter(Subject_Group_By_Year_MMU_UoS_Summary, `Cycle Year` == 2016)
View(Subject_Group_2016_MMU_UoS_Summary)
#remove ` marks from data in key columns in summary subject document
Subject_Group_2016_Summary$`Subject Group (Summary Level)` <- gsub(pattern = "'", replacement = "", x = Subject_Group_2016_Summary$`Subject Group (Summary Level)`)
View(Subject_Group_2016_Summary)
#create 2016 subject application numbers document combining MMU, UoS and Summary figures
Subject_Group_2016_MMU_UoS_Plus_Summary <- bind_rows(Subject_Group_2016_MMU_UoS_Summary, Subject_Group_2016_Summary)
#replace NA values with 0 ahead of creating a new column
Subject_Group_2016_MMU_UoS_Plus_Summary[is.na(Subject_Group_2016_MMU_UoS_Plus_Summary)] <- 0
#rename column to remove spaces to help with creating combination column
names(Subject_Group_2016_MMU_UoS_Plus_Summary)[names(Subject_Group_2016_MMU_UoS_Plus_Summary) == 'Number of Applications'] <- 'numapps'
names(Subject_Group_2016_MMU_UoS_Plus_Summary)[names(Subject_Group_2016_MMU_UoS_Plus_Summary) == 'Cycle Year'] <- 'cycleyear'
names(Subject_Group_2016_MMU_UoS_Plus_Summary)[names(Subject_Group_2016_MMU_UoS_Plus_Summary) == 'Provider Name'] <- 'providername'
names(Subject_Group_2016_MMU_UoS_Plus_Summary)[names(Subject_Group_2016_MMU_UoS_Plus_Summary) == 'Subject Group (Summary Level)'] <- 'subjectgroupsummarylevel'
names(Subject_Group_2016_MMU_UoS_Plus_Summary)[names(Subject_Group_2016_MMU_UoS_Plus_Summary) == 'Applications'] <- 'applications'
View(Subject_Group_2016_MMU_UoS_Plus_Summary)
#create combined Applications column to show total applications for MMU, UoS and Summary
Subject_Group_2016_MMU_UoS_Plus_Summary <- mutate(Subject_Group_2016_MMU_UoS_Plus_Summary, Applications = numapps + sum)
View(Subject_Group_2016_MMU_UoS_Plus_Summary)
#filter smaller version of comparison data to only include required columns
Subject_Group_2016_MMU_UoS_Plus_Summary_Small <- select(Subject_Group_2016_MMU_UoS_Plus_Summary, providername, subjectgroupsummarylevel, Applications)
View(Subject_Group_2016_MMU_UoS_Plus_Summary_Small)
#remove institution codes from front of MMU and UoS, to help with UCAS Total rows rename
Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername <- gsub(pattern = "S03 ", replacement = "", x = Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername <- gsub(pattern = "M40 ", replacement = "", x = Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername)
View(Subject_Group_2016_MMU_UoS_Plus_Summary_Small)
#change UCAS total name from 0 to Total (UCAS wide)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername <- gsub(pattern = "0", replacement = "Total (UCAS wide)", x = Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername)
View(Subject_Group_2016_MMU_UoS_Plus_Summary_Small)
#plotted scatterplot, but realise I will need to convert values to percentages first
ggplot(Subject_Group_2016_MMU_UoS_Plus_Summary_Small, aes(x = subjectgroupsummarylevel, y = Applications, col = providername)) + geom_point() + geom_smooth(lwd = 2, se = FALSE)
#calculated total applications by provider that are classified by subject and append
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Total <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small %>% group_by(providername) %>% mutate(totalapps = sum(Applications))
View(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Total)
#calculate percentage of each provider's applications that each subject makes up (including expressing as a percentage)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Total %>% mutate(subjappspercent = Applications/totalapps)
View(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra$subjappspercent <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra$subjappspercent * 100
View(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra)
#round percentages to nearest whole percentage
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra %>% mutate(subjappspercent = round(subjappspercent, 0))
#plot scatterplot with percentages instead
ggplot(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra, aes(x = subjectgroupsummarylevel, y = subjappspercent, col = providername)) + geom_point() + geom_smooth(lwd = 2, se = FALSE)
#scatterplot didn't give a clear view of differences, so try column chart instead
ggplot(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra, aes(x = subjectgroupsummarylevel, y = subjappspercent, fill = providername)) + geom_col(position = "dodge")
#column chart suggests there are major differences between MMU and UoS (green and red columns), so create table to show differences
Subject_Group_2016_MMU_UoS_Percentage_Only <- filter(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra, providername == c("The Manchester Metropolitan University", "The University of Salford"))
#remove UCAS total rows
Subject_Group_2016_MMU_UoS_Percentage_Only <- filter(Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra, providername != "Total (UCAS wide)")
#remove columns other than provider, subject and percentage
Subject_Group_2016_MMU_UoS_Percentage_Only <- select(Subject_Group_2016_MMU_UoS_Percentage_Only, providername, subjectgroupsummarylevel, subjappspercent)
View(Subject_Group_2016_MMU_UoS_Percentage_Only)
#spread provider columns out across table
Subject_Group_2016_MMU_UoS_Percentage_Only_Spread <- spread(Subject_Group_2016_MMU_UoS_Percentage_Only, providername, subjappspercent)
View(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread)
#calculate difference between MMU and Salford (so any subject that Salford has a lower percentage in shows as negative)
Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals <- mutate(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread, difference = `The University of Salford` - `The Manchester Metropolitan University`)
View(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals)
#arrange table in descending order of differences in percentage
Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals <- arrange(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals, difference)
View(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals)
