#load library
library(shinytest)
library(shiny)
library(leaflet)

testServer(server,{
  
  #check names
  cat("Initially, input$go is NULL, right?", is.null(input$go), "\n")
  cat("Initially, input$scientificname is NULL, right?", is.null(input$scientificname), "\n")

  #set input values
  session$setInputs(
    scientificname = occurrence$scientificName[sample(1:1000,1)],
    type="Scientific Name",
    go=2
    )
  
  cat("Scientific name is ",input$scientificname, "\n")
  
  #processing data
  cat("Processing Data", "\n")
  
  #run reactive function
  occurrence_test <- occurrence_processed()
  
  #check if result has at least 1 row
  if (nrow(occurrence_test>0)){
    
    #test complete and successful
    cat("Success! ",nrow(occurrence_test)," records found", "\n")

  }
  
  else{
    
   #test failed if no rows
   cat("Test failed, no records found","\n") 
  }
  
})
