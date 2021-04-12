# Define UI for application that draws a histogram
ui <- fluidPage(
  #theme = shinytheme("sandstone"),
  
  # Application title
  titlePanel("The Mining Stock Scale"),
  

    
    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(

          tabPanel("ADJUST YOUR MINING STOCK",
                   # Sidebar with a slider input for number of bins 
                  wellPanel( 
                
                      sliderInput("bins1",
                                   "Weight on Grade 1",
                                   min = 0,  max = 20, value = 17, width="100%"),
                      sliderInput("bins2",
                                   "Weight on Grade 2",
                                   min = 0, max = 20, value = 9, width="100%"),
                      sliderInput("bins3",
                                   "Weight on Grade 3",
                                   min = 0, max = 6, value = 1.2,step = .2, width="100%")
                            ),
                     
                      plotOutput("distPlot",brush = "user_brush"),
                      
                      DT::dataTableOutput("table"),
                  
                      downloadButton(outputId = "mydownload", label = "Download Table")
                      
                   ),
          tabPanel("DOCUMENTATION - Pdf", 
                   h4("To learn more about Shiny Apps"),
                   tags$iframe(style="height:600px; width:100%; scrolling=yes",
                               src="https://cran.r-project.org/web/packages/shiny/shiny.pdf")
                  ),
          tabPanel("DOCUMENTATION - Video", 
                   h4("Video documentation - Embedded from Youtube"),
                   tags$iframe(style="height:900px; width:900px",
                               src="https://www.youtube.com/embed/vySGuusQI3Y")
          ),
          tabPanel("DATA TABLE WITH THE UNDERLYING DATA", 
                   DT::dataTableOutput("tableDT")
                   )
        )
    )
  
)
