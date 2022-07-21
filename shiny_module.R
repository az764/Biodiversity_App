library(leaflet)
library(tidyverse)

#map plot shiny module UI
mapplot_ui <- function(id) {
  ns <- NS(id)
  
  #tab panel
  tabPanel("Map",
           
           #leaflet map
           leafletOutput(ns("map"))
           )
  
}

#map plot shiny module server
mapplot_server <- function(id, occurrence) {
  
  moduleServer(
    id,
    function(input, output, session) {
      
      #render map
      output$map <- renderLeaflet({
    
        leaflet()%>%
          addProviderTiles(providers$CartoDB.Positron)%>%
          #add circles to represent occurrences
          addCircles(data=occurrence,lng=~decimalLongitude, lat= ~decimalLatitude,group="All",layerId = ~gbifID, popup = ~popup, opacity = 1,radius = 9,weight = 9)
        
        })
    }
  )
}



#timeline plot shiny module UI
timelineplot_ui <- function(id) {
  ns <- NS(id)

  #tab panel  
  tabPanel("Plot",
           
           #plot timeline chart
           plotOutput(ns("timelineplot"))
           )
  
}


#timeline plot shiny module server
timelineplot_server <- function(id, occurrence) {
  
  moduleServer(
    id,
    function(input, output, session) {
      
      #render plot
      output$timelineplot <- renderPlot({
        
        #generate time series plot
        ggplot(data=occurrence,aes(x=eventDate,y=1,group=1))+
          geom_point(colour="Red",lwd=3)+
          #add labels and formatting
          labs(title = paste0("Observations Timeline"),x="Date")+
          theme(text = element_text(size=15),axis.title.y = element_blank(),axis.text.y = element_blank(),axis.ticks.y = element_blank())
      })
      
    }
  )
}

