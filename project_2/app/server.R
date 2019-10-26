#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
ShinyServer <- function(input, output) {
  
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