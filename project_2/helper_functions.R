#Load in necessary packages
library(tidyverse)
library(ggplot2)
library(data.table)
library(shiny)


#load in dataset
UMD.data=fread(file="C:/Users/alex/Documents/GitHub/bios611-projects-fall-2019-arquinter/project_1/data/UMD_Services_Provided_20190719.tsv")
Durham.homeless.pop = fread("~/GitHub/bios611-projects-fall-2019-arquinter/project_2/data/Homeless_Population_Point_in_Time_Count.csv")
Durham.homeless.counts = Durham.homeless.pop %>% filter(measures %in% c("Total Homeless", "Chronically Homeless", "Sheltered Homeless",
    "Sheltered Chronically Homeless", "Unsheltered Homeless", "Unsheltered Chronically Homeless"))

#create analysis datasets
UMD.derived = UMD.data %>% mutate(ndate=as.Date(Date, "%m/%d/%Y")) %>% mutate(year=as.factor(format(as.Date(Date, "%m/%d/%Y"), "%Y")))
food.reg.df = na.omit(select(UMD.derived, ndate, year, `Food Pounds`)) %>%
  filter(!year %in% c("1931", "1941", "1951", "1961", "1971", "1981", "2021", "2022"), `Food Pounds` < 1000) %>% droplevels()
school.reg.df = na.omit(select(UMD.derived, ndate, year, `School Kits`)) %>%
  filter(!year %in% c("1931", "1941", "1951", "1961", "1971", "1981", "2021", "2022")) %>% droplevels()


ui <- navbarPage("Navbar",
                 tabPanel("Plot",
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("org", "Organization",
                                           c("Total Homeless"="Total Homeless", "Chronically Homeless"="Chronically Homeless",
                                             "Sheltered Homeless" = "Sheltered Homeless", "Sheltered Chronically Homeless" = 
                                             "Sheltered Chronically Homeless", "Unsheltered Homeless" = "Unsheltered Homeless",
                                             "Unsheltered Chronically Homeless" = "Unsheltered Chronically Homeless")
                              )
                            ),
                            mainPanel(
                              plotOutput("countplot")
                            )
                          )
                 )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$countplot <- renderPlot({
    
    data = switch(input$org,
                  "Total Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Total Homeless",],
                  "Chronically Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Chronically Homeless",],
                  "Sheltered Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Sheltered Homeless",],
                  "Sheltered Chronically Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Sheltered Chronically Homeless",],
                  "Unsheltered Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Unsheltered Homeless",],
                  "Unsheltered Chronically Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Unsheltered Chronically Homeless",])
    
    ggplot(data, aes(x=year, y=count_)) + geom_bar(stat = "identity")
    
  })
}
