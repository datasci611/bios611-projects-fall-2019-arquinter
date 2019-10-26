#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(RCurl)

script <- getURL("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-arquinter/master/project_2/helper_functions.R", ssl.verifypeer = FALSE)

eval(parse(text = script))

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

shinyApp(ui = ui, server = server)

deployApp()