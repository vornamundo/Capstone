#prevent warnings showing through
warnings=False
#create reduced dataframe to compare overall student numbers for MMU and Salford
#remove regions column and check outcome
MMU_Salf_App_Numbers_1 <- select(Provider_Domicile_EOC_data_resource_2016_DR4_005_03, "cycle_year", "provider_name", "number_of_applications")
#group by cycle year and provider name, and summarise number of applications, and check outcome
MMU_Salf_App_Numbers_2 <- MMU_Salf_App_Numbers_1 %>% group_by(cycle_year, provider_name) %>% summarise(number_of_applications = sum(number_of_applications))
#remove all other providers than MMU and Salford, and check outcome
MMU_Salf_App_Numbers_3 <- filter(MMU_Salf_App_Numbers_2, provider_name %in% c("M40 The Manchester Metropolitan University", "S03 The University of Salford"))
#arrange in provider order, and check outcome
MMU_Salf_App_Numbers_4 <- arrange(MMU_Salf_App_Numbers_3, provider_name, cycle_year)
#spread year values in cycle year columns into their own columns, and check outcome
MMU_Salf_App_Numbers_5 <- spread(MMU_Salf_App_Numbers_4, cycle_year, number_of_applications)
#spread provider names in provider name columns into their own columns instead, and check outcome
MMU_Salf_App_Numbers_6 <- spread(MMU_Salf_App_Numbers_4, provider_name, number_of_applications)
#sum the total 
sum(MMU_Salf_App_Numbers_6$`M40 The Manchester Metropolitan University`)
sum(MMU_Salf_App_Numbers_6$`S03 The University of Salford`)
#plot scatter plot of application numbers to each institution over time
applications_by_year_by_inst <- ggplot(MMU_Salf_App_Numbers_4, aes(x = cycle_year, y = number_of_applications, col = provider_name)) + geom_point() + geom_smooth(lwd = 2, se = FALSE)
#tidy up column names in MMU_Salf_App_Numbers_6 by adding underscore, and check outcome
names(MMU_Salf_App_Numbers_6) <- gsub(" ", ".", names(MMU_Salf_App_Numbers_6))
str(MMU_Salf_App_Numbers_6)
#create column showing total applications by year for the two institutions combined, and check outcome
MMU_Salf_App_Numbers_7 <- MMU_Salf_App_Numbers_6 %>% mutate(total = M40.The.Manchester.Metropolitan.University + S03.The.University.of.Salford)
#calculate percentage of two institutions' combined applications received by each institution, per year, and check outcome
MMU_Salf_App_Numbers_8 <- MMU_Salf_App_Numbers_7 %>% mutate(MMU_percentage = M40.The.Manchester.Metropolitan.University/total, UoS_percentage = S03.The.University.of.Salford/total)
#when trying to gather institution name columns into one, cycle.year wasn't recognised, so lookedup up fix on stackoverflow
MMU_Salf_App_Numbers_8 <- as.data.frame(MMU_Salf_App_Numbers_8)
#gathered HE institution names to reshape data
MMU_Salf_App_Numbers_9 <- gather(MMU_Salf_App_Numbers_8, "HE_institution", "n", 2:3)
#selected only relevant value for percentages to create new table
MMU_Salf_App_Numbers_10 <- select(MMU_Salf_App_Numbers_9, cycle_year, MMU_percentage, UoS_percentage, HE_institution)
#create two tables, one for each institution, to separate out percentages and then combine again
MMU_only_percentage <- filter(MMU_Salf_App_Numbers_10, HE_institution %in%  "M40.The.Manchester.Metropolitan.University")
UoS_only_percentage <- filter(MMU_Salf_App_Numbers_10, HE_institution %in% "S03.The.University.of.Salford")
#realise redundant percentage column now needs removing from each of these
MMU_only_percentage <- select(MMU_only_percentage, cycle_year, MMU_percentage, HE_institution)
UoS_only_percentage <- select(UoS_only_percentage, cycle_year, UoS_percentage, HE_institution)
#need to rename percentage columns in each so they match ahead of the join, and couldn't seem to make rename work
MMU_only_percentage <- mutate(MMU_only_percentage, percentage = MMU_percentage)
UoS_only_percentage <- mutate(UoS_only_percentage, percentage = UoS_percentage)
#remove non-matching columns showing percentages
MMU_only_percentage <- select(MMU_only_percentage, cycle_year, HE_institution, percentage)
UoS_only_percentage <- select(UoS_only_percentage, cycle_year, HE_institution, percentage)
#combine the two dataframes back together
MMU_Salf_App_Numbers_11 <- bind_rows(UoS_only_percentage, MMU_only_percentage)
#plot bar chart to see how percentage of applications varies over time
application_percentage_by_year_by_inst <- ggplot(MMU_Salf_App_Numbers_11, aes(x = cycle_year, y = percentage, fill = HE_institution)) + geom_bar(stat = "identity") + geom_smooth()
#import provider by subject data
EOC_data_resource_2016_DR4_016_03 <- read_csv("UCASData/EOC_data_resource_2016-DR4_016_03.csv", col_names = TRUE, skip = 5)
#clarify name of the file to make it easier to work with
EOC_data_resource_2016_DR4_016_03_Provider_Subject <- EOC_data_resource_2016_DR4_016_03
#view summary of file
summary(EOC_data_resource_2016_DR4_016_03_Provider_Subject)
#remove blank columns from file and rename, and view to check
Provider_Subject_EOC_data_resource_2016_DR4_016_03 <- select(EOC_data_resource_2016_DR4_016_03_Provider_Subject, -X5)
#summarise by year and subject only, removing provider, and view to check
Subject_Group_By_Year_Summary <- Provider_Subject_EOC_data_resource_2016_DR4_016_03 %>% group_by(`Cycle Year`, `Subject Group (Summary Level)` ) %>% summarise(sum = sum(`Number of Applications`))
#create file only containing applications by subject for 2016 overall (to allow non-time series comparison with MMU and UoS)
Subject_Group_2016_Summary <- filter(Subject_Group_By_Year_Summary, `Cycle Year` == 2016)
#remove ` marks from data in key columns in provider subject document
Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Provider Name` <- gsub(pattern = "'", replacement = "", x = Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Provider Name`)
Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Subject Group (Summary Level)` <- gsub(pattern = "'", replacement = "", x = Provider_Subject_EOC_data_resource_2016_DR4_016_03$`Subject Group (Summary Level)`)
#create summary of subject and year just for MMU and UoS
Subject_Group_By_Year_MMU_UoS_Summary <- Provider_Subject_EOC_data_resource_2016_DR4_016_03 %>% filter(`Provider Name` %in% c("M40 The Manchester Metropolitan University", "S03 The University of Salford"))
#filter summary of subject and year just for MMU and UoS down to just 2016
Subject_Group_2016_MMU_UoS_Summary <- filter(Subject_Group_By_Year_MMU_UoS_Summary, `Cycle Year` == 2016)
#remove ` marks from data in key columns in summary subject document
Subject_Group_2016_Summary$`Subject Group (Summary Level)` <- gsub(pattern = "'", replacement = "", x = Subject_Group_2016_Summary$`Subject Group (Summary Level)`)
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
#create combined Applications column to show total applications for MMU, UoS and Summary
Subject_Group_2016_MMU_UoS_Plus_Summary <- mutate(Subject_Group_2016_MMU_UoS_Plus_Summary, Applications = numapps + sum)
#filter smaller version of comparison data to only include required columns
Subject_Group_2016_MMU_UoS_Plus_Summary_Small <- select(Subject_Group_2016_MMU_UoS_Plus_Summary, providername, subjectgroupsummarylevel, Applications)
#remove institution codes from front of MMU and UoS, to help with UCAS Total rows rename
Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername <- gsub(pattern = "S03 ", replacement = "", x = Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername <- gsub(pattern = "M40 ", replacement = "", x = Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername)
#change UCAS total name from 0 to Total (UCAS wide)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername <- gsub(pattern = "0", replacement = "Total (UCAS wide)", x = Subject_Group_2016_MMU_UoS_Plus_Summary_Small$providername)
