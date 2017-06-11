
#
#Idea: ' real time prediction with tab + text field with button to paste larger text
# Code on Github - just 'as is' of als project zoals bij Hunters Help??
#

library(shiny)
library(shinyjs)
library(shinythemes)


appCSS <- "
#loading-content {
position: absolute;
background: ##95B3D7;
opacity: 0.9;
z-index: 100;
left: 0;
right: 0;
height: 100%;
text-align: center;
color: ##95B3D7;
}
"





# Define UI 
shinyUI(fluidPage(theme = shinytheme("cerulean"), 
                                     useShinyjs(),
                                     inlineCSS(appCSS),
                                     
                                     # Loading message
                                     div(
                                             id = "loading-content",
                                             h2("Loading... Please wait a few seconds"),
                                             hr(),
                                             img(src='title.png', align = "center"),
                                             hr(),
                                             img(src='bgfoto.png', align = "center")
                                     ),
                  
hidden(
        div(
                id = "app-content",
        
                  
  # Application title
  titlePanel( img(src='title.png', align = "left")),
 
  

  # Sidebar  - use for explanatory text 
  sidebarLayout(
    sidebarPanel(
            
## show explanations and probabilities here  
            ##checkboxGroupInput("words", "Choose word", ""),
            hr(),
            selectInput("words", "Your next word could be:", choices = "waiting for input..."),
            hr(),
            actionButton("getword", "Add word"),
            singleton(
                    tags$head(tags$script(src = "message-handler.js"))
            ),     
            h6("Click to add your next word to the text"),
            hr(),
            tableOutput("view"),
            h6("The top-5 predictions and their probabilities")
            
       
    ), ## close sidebar panel
    
    ## Main Panel = text box + automatic drop-down list with prediction, at every keystroke? Or button?
    
    mainPanel(
            
            hr(),
            textAreaInput("text1", "Please type your text here", value = "", width = "500px", height = "100px"),
            
            ## Predict button
            actionButton("predict", "Predict next word"),
            singleton(
                    tags$head(tags$script(src = "message-handler.js"))
            ),     
            h6("Enter text and click to predict the next word"),
            hr(),
            
            
            img(src='bgfoto.png', align = "left")
   
            
            
        ) ## close main panel
  ) ## close sidebar layout (?)
        ) ## clode loading screen
)
)) ## close shiny ui and fluid page
