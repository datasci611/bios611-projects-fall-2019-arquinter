#Load in necessary packages
library(tidyverse)
library(ggplot2)
library(data.table)
library(shiny)
library(httr)

#load in dataset
UMD.data=read_tsv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-arquinter/master/project_2/data/UMD_Services_Provided_20190719.tsv", na="**")
Durham.homeless.pop = read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-arquinter/master/project_2/data/Homeless_Population_Point_in_Time_Count.csv")
Durham.homeless.counts = Durham.homeless.pop %>% filter(measures %in% c("Total Homeless", "Chronically Homeless", "Sheltered Homeless",
    "Sheltered Chronically Homeless", "Unsheltered Homeless", "Unsheltered Chronically Homeless"))

#create analysis datasets
UMD.derived = UMD.data %>% mutate(ndate=as.Date(Date, "%m/%d/%Y")) %>% mutate(year=as.factor(format(as.Date(Date, "%m/%d/%Y"), "%Y")))
food.reg.df = na.omit(select(UMD.derived, ndate, year, `Food Pounds`)) %>%
  filter(!year %in% c("1931", "1941", "1951", "1961", "1971", "1981", "2021", "2022"), `Food Pounds` < 1000) %>% droplevels()
school.reg.df = na.omit(select(UMD.derived, ndate, year, `School Kits`)) %>%
  filter(!year %in% c("1931", "1941", "1951", "1961", "1971", "1981", "2021", "2022")) %>% droplevels()