library(shiny)
library(shinyjs)
source("GetGrams.R", local = ) 

## tipp: set max size
options(shiny.maxRequestSize=30*1024^2)
##shinyapps::showLogs()



## server function
shinyServer(function(input, output, session) {
   
        ## Read in table(s) with ngrams + probability data (with loading bar)
        ##withProgress(expr = {load("prob_tables.RData") }, message = "Loading... Please wait")
        ##Loading with screen
        load("prob_tables.RData") 
        hide(id = "loading-content", anim = TRUE, animType = "fade")    
        show("app-content")

        ## include algorithm
        source("GetGrams.R", local = TRUE) 
        
        ## text field on main panel
        output$text1 <- renderText({ input$text1 })
        
        ## pre-fill selection
        predwords <- getgrams("")
        updateSelectInput(session, "words", choices = predwords$word) 
        output$view <- renderTable({predwords}, digits = 4) 
        
       
       observeEvent(input$predict, { 
                
                predwords <- getgrams(input$text1)
                updateSelectInput(session, "words", choices = predwords$word) 
                output$view <- renderTable({predwords}, digits = 4) 
                
         }) ## observe event input predict             
                
               
       observeEvent(input$getword, { 
       
                textVar <- paste(input$text1, input$words)
                updateTextAreaInput(session, "text1", value= textVar)
                
       }) ## observe event input getword     
                        
                
 
## extra stop when browser is closed 
session$onSessionEnded(stopApp)
  
})
