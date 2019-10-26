#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(RCurl)

script <- getURL("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-arquinter/master/project_2/helper_functions.R", ssl.verifypeer = FALSE)

eval(parse(text = script))

# Define UI for application that draws a histogram
shinyUI(navbarPage("Navbar",
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
)
