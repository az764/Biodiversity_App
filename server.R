#server logic
server<- function(input, output, session) {
  
  #process occurrence data when 'go' button is pressed
  occurrence_processed <- eventReactive(input$go,{
    
    #if user selects scientific name
    if(input$type=="Scientfic Name"){
    
      #define name
      name <- input$scientificname
   
      #filter occurrence to records from only the selected scientific name
      occurrence<- occurrence[occurrence$scientificName==name & !is.na(occurrence$decimalLatitude) & !is.na(occurrence$decimalLongitude),]
   
    }
    
    #if user selects vernacular name
    else if(input$type=="Vernacular Name"){
      
      #define name
      name <- input$vernacularname
      
      #filter occurrence to selected vernacular name
      occurrence<- occurrence[occurrence$vernacularName==name & !is.na(occurrence$decimalLatitude) & !is.na(occurrence$decimalLongitude),]
      
    }
    
    #if no occurrences found then inform user 
    if(nrow(occurrence) == 0){
     showNotification("No occurrences found to display on map, please select a different specie",type = "error")
     stop()
     }
   
    else {
      
      #create map popup
      occurrence$popup<- paste0(
       #ID
       "<b> ID: ",  occurrence$occurrenceID ,"</b>",
       "<br/>",
       #locality
       "Locality: ",occurrence$locality,
       "<br/>",
       #date
       "Date: ",occurrence$eventDate
      )
      
      return(occurrence)
      
    } 
   
  })
  
  
  #shiny module for map plot
  observe({
    
    #require occurrence processed function
    req(occurrence_processed())
    
    #module map output
    mapplot_server("map",occurrence_processed())
    
    #module chart output
    timelineplot_server("timelineplot",occurrence_processed())
  })

}
