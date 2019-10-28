#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(RCurl)
library(tidyverse)
library(ggplot2)
library(data.table)
library(shiny)
library(httr)
library(RColorBrewer)

script <- getURL("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-arquinter/master/project_2/helper_functions.R", ssl.verifypeer = FALSE)

eval(parse(text = script))

# Define server logic required to draw a histogram
ShinyServer <- function(input, output) {
  
  output$countplot = renderPlot({
    
    data = switch(input$org,
                  "Total Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Total Homeless",],
                  "Chronically Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Chronically Homeless",],
                  "Sheltered Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Sheltered Homeless",],
                  "Sheltered Chronically Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Sheltered Chronically Homeless",],
                  "Unsheltered Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Unsheltered Homeless",],
                  "Unsheltered Chronically Homeless" = Durham.homeless.counts[Durham.homeless.counts[,5]=="Unsheltered Chronically Homeless",])
    
    ggplot(data, aes(x=year, y=count_, fill=as.factor(year))) + geom_bar(stat = "identity") + theme_minimal() + theme(legend.position = "none") +
      scale_fill_brewer(palette = "Spectral")
    
  })
  
  output$lineg = renderPlot({
    ggplot(Size.reg.df, aes(x=as.numeric(as.character(year)), y=ave)) + geom_point(color = "Blue") + geom_line(color = "Red") +
      xlim(input$year[1], input$year[2]) + theme_minimal() + labs(x="Year", y="Average Group Size",
        title="Average Number of People in Group when Food is Provided Over Time")
  })
  output$lineg2 = renderPlot({
    ggplot(food.reg.df, aes(x=as.numeric(as.character(year)), y=ave)) + geom_point(color = "Green") + geom_line(color = "Yellow") +
      xlim(input$year[1], input$year[2]) + theme_minimal() + labs(x="Year", y="Average Group Size",
                                                                  title="Average Pounds of Food Provided per Group Over Time")
  })
}