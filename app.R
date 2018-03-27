#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
ui <- fluidPage( ###You almost always want to start with the wrapper function fulidPage().
                ### fluidPage allows your app to resize and render to fit the user's browser window. 
   
   # The main title for your app
   titlePanel("Larry Bird's Jumpshot"),
   
   # sidebarLayout tells your app where to put the panels.
   sidebarLayout(
      sidebarPanel( ###Starting from the left...... use position = "right" to go in the opposite direction.
         sliderInput(inputId = "bins",
                     label = "Number of bins:",
                     min = 5,
                     max = 20,
                     value = 10),###Value is the starting value.
         sliderInput(inputId = "games",
                     label = "Number of games:",
                     min = 20,
                     max = 400,
                     value = 82),
         checkboxInput("playoffs", "Playoffs", value = FALSE) ##Starts un-checked. 
         ),
      
        
        
      
      
     
      #####Ending on the right.
      mainPanel(  
         plotOutput("distPlot"),
         
         br(), ###Like <br/> or <br> in HTML
         
         img(src = "larry.jpg", height = 200, width = 133.5, align = "left", hspace = 45),
         img(src = "celtics8586.jpeg", height = 200, width = 475, aligh = "middle"),
         img(src = "larry2.jpg",height = 200, width = 125.5, align = "right")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R\
      # also use input$games to determine how many games to randomly sample.
      
     if(input$playoffs)
     {
       shots = rpois(input$games, lambda = 20) 
     }
     else
     {
       shots = rpois(input$games, lambda = 15) 
     }
     
     
     
      bins <- seq(min(shots), max(shots), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(shots, breaks = bins, col = 'green4', border = 'white', 
           xlab = "Number of Jumpshots taken by Larry Bird")
   })
}

# Run the application. Everytime the user changes an input, the app re-runs the server code. 
shinyApp(ui = ui, server = server)

