#prevent warnings showing through
warnings=False
#plotted scatterplot, but realise I will need to convert values to percentages first
ggplot(Subject_Group_2016_MMU_UoS_Plus_Summary_Small, aes(x = subjectgroupsummarylevel, y = Applications, col = providername)) + geom_point() + geom_smooth(lwd = 2, se = FALSE)
#calculated total applications by provider that are classified by subject and append
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Total <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small %>% group_by(providername) %>% mutate(totalapps = sum(Applications))
#calculate percentage of each provider's applications that each subject makes up (including expressing as a percentage)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Total %>% mutate(subjappspercent = Applications/totalapps)
Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra$subjappspercent <- Subject_Group_2016_MMU_UoS_Plus_Summary_Small_Extra$subjappspercent * 100
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
#spread provider columns out across table
Subject_Group_2016_MMU_UoS_Percentage_Only_Spread <- spread(Subject_Group_2016_MMU_UoS_Percentage_Only, providername, subjappspercent)
#calculate difference between MMU and Salford (so any subject that Salford has a lower percentage in shows as negative)
Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals <- mutate(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread, difference = `The University of Salford` - `The Manchester Metropolitan University`)
#arrange table in descending order of differences in percentage
Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals <- arrange(Subject_Group_2016_MMU_UoS_Percentage_Only_Spread_Totals, difference)
#to look at applicant region of origin spread, create provider by origin table just for 2016
Provider_Domicile_2016 <- filter(Provider_Domicile_EOC_data_resource_2016_DR4_005_03, cycle_year == 2016)
#create tables for each of MMU and UoS for 2016 only
Provider_Domicile_2016_MMU <- filter(Provider_Domicile_2016, provider_name == "M40 The Manchester Metropolitan University")
View(Provider_Domicile_2016_MMU)
Provider_Domicile_2016_UoS <- filter(Provider_Domicile_2016, provider_name == "S03 The University of Salford")
#join tables together
Provider_Domicile_2016_MMU_and_UoS <- full_join(Provider_Domicile_2016_MMU, Provider_Domicile_2016_UoS)
#remove year column
Provider_Domicile_2016_MMU_and_UoS <- select(Provider_Domicile_2016_MMU_and_UoS, provider_name:number_of_applications)
#spread table out using providers, and check result
Provider_Domicile_2016_MMU_and_UoS_Spread <- spread(Provider_Domicile_2016_MMU_and_UoS, provider_name, number_of_applications)
View(Provider_Domicile_2016_MMU_and_UoS_Spread)
#realise spreading the other way would make it easier to create a total
Provider_Domicile_2016_MMU_and_UoS_Spread_Other <- spread(Provider_Domicile_2016_MMU_and_UoS, "applicant_domicile_(region)", number_of_applications)
View(Provider_Domicile_2016_MMU_and_UoS_Spread_Other)
#sum rows to give total for each provider
Provider_Domicile_2016_MMU_and_UoS_Spread_Other_w_Totals <- Provider_Domicile_2016_MMU_and_UoS_Spread_Other %>% mutate(sum = rowSums(.[2:13]))
View(Provider_Domicile_2016_MMU_and_UoS_Spread_Other_w_Totals)
#gather table into other format
Provider_Domicile_2016_MMU_and_UoS_Spread_Other_w_Totals_Horiz <- Provider_Domicile_2016_MMU_and_UoS_Spread_Other_w_Totals %>% gather("applicant_region", "applications", 2:14)
#create separate MMU and UoS tables
Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Horiz <- Provider_Domicile_2016_MMU_and_UoS_Spread_Other_w_Totals %>% filter(provider_name == "M40 The Manchester Metropolitan University")
View(Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Horiz)
Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Horiz <- Provider_Domicile_2016_MMU_and_UoS_Spread_Other_w_Totals %>% filter(provider_name == "S03 The University of Salford")
#change shape of those tables to allow calculation of percentage
Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Vert <- Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Horiz %>% gather("applicant_region", "applications", 2:13)
View(Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Vert)
Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Vert <- Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Horiz %>% gather("applicant_region", "applications", 2:13)
View(Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Vert)
#add column showing percentage to each table
Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Vert <- Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Vert %>% mutate(percentage_apps = (applications / sum)*100)
View(Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Vert)
Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Vert <- Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Vert %>% mutate(percentage_apps = (applications / sum)*100)
#spread UoS table to reshape and reduce to only show regions and percentages
Provider_Domicile_2016_UoS_Percentage_Apps_Region <- Provider_Domicile_2016_UoS_Spread_Other_w_Totals_Vert %>% spread(provider_name, percentage_apps)
Provider_Domicile_2016_UoS_Percentage_Apps_Region <- Provider_Domicile_2016_UoS_Percentage_Apps_Region %>% select(applicant_region, "S03 The University of Salford")
View(Provider_Domicile_2016_UoS_Percentage_Apps_Region)
#spread MMU table to reshape and reduce to only show regions and percentages
Provider_Domicile_2016_MMU_Percentage_Apps_Region <- Provider_Domicile_2016_MMU_Spread_Other_w_Totals_Vert %>% spread(provider_name, percentage_apps)
Provider_Domicile_2016_MMU_Percentage_Apps_Region <- Provider_Domicile_2016_MMU_Percentage_Apps_Region %>% select(applicant_region, "M40 The Manchester Metropolitan University")
View(Provider_Domicile_2016_MMU_Percentage_Apps_Region)
#join percentage tables together for both institutions (by region)
Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region <- inner_join(Provider_Domicile_2016_MMU_Percentage_Apps_Region, Provider_Domicile_2016_UoS_Percentage_Apps_Region, by = "applicant_region")
View(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region)
#rename columns in combined document to make them easier to work with
names(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region)[names(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region) == 'M40 The Manchester Metropolitan University'] <- 'MMU'
names(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region)[names(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region) == 'S03 The University of Salford'] <- 'UoS'
View(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region)
#round to nearest whole percentage
Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region <- Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region %>% mutate(MMU = round(MMU, 0))
Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region <- Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region %>% mutate(UoS = round(UoS, 0))
View(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region)
#reshape data to allow plotting of chart to compare percentage from each region
Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region_Clean <- Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region %>% gather("provider", "percentage_from_region", 2:3)
View(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region_Clean)
#plot column chart to show differences in regional percentages
applications_2016_by_region_by_inst_percentage <- ggplot(Provider_Domicile_2016_MMU_and_UoS_Percentage_Apps_Region_Clean, aes(x = applicant_region, y = percentage_from_region, fill = provider)) + geom_col(position = "dodge")
plot(applications_2016_by_region_by_inst_percentage)