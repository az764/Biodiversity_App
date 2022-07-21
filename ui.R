#load library
library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

#Dashboard UI
navbarPage("Biodiversity Dashbaord",
           
           #Create tab
           tabPanel("Map Visual",
                    
                    #Sidebar
                    sidebarPanel(
                      
                      #description
                      paste0("Please select the name Scientific/Vernacular name and click 'Go',
                             a map will then be displayed with occurences and a timeline on the tabs"),
                      
                      br(),
                      
                      #Option to select scientific name or vernacular name
                      radioButtons("type","Select type: ",choices = c("Scientfic Name","Vernacular Name")),
                      
                      #If user has selected scientific name then display options
                      conditionalPanel(
                        "input.type=='Scientfic Name'",
                        selectizeInput("scientificname","Select scientific name: ", choices = c(unique(occurrence$scientificName)))
                      ),
                      
                      #If user has selected vernacular name then display options
                      conditionalPanel(
                        "input.type=='Vernacular Name'",
                        selectizeInput("vernacularname","Select Vernacular name: ", choices = c(unique(occurrence$vernacularName)))
                      ),
                      
                      #Go button to trigger visualisation processing
                      actionButton("go","Go")

                    ),
                    
                    #Main page
                    mainPanel(
                      
                      tabsetPanel(type="tabs",
                                  
                                  #shiny module to plot map
                                  mapplot_ui("map"),
                                  
                                  #shiny module to plot timeline of occurrences
                                  timelineplot_ui("timelineplot")
                                  )
                    )
           
           )
)