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