# Define server logic required to draw a histogram
server <- function(input, output) {
  ## If a package is installed, it will be loaded. If any 
  ## are not, the missing package(s) will be installed 
  ## from CRAN and then loaded.
  
  
  ## First specify the packages of interest
  packages = c("shiny", "shinythemes", "DT","ggplot2", "readr", "pracma")
  
  ## Now load or install&load all
  #package.check <- lapply(
  #  packages,
  #  FUN = function(x) {
  #    if (!require(x, character.only = TRUE)) {
  #      install.packages(x, dependencies = TRUE)
  #      library(x, character.only = TRUE)
  #    }
  #  }
  #)
  
  list.of.packages <- c("shiny", "shinythemes", "DT","ggplot2", "readr")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  
  library("shiny")
  library("shinythemes")
  library("DT")
  library("ggplot2")
 library("readr")
 # library("tidyverse")
 # library("renv")


  
  
  
 Data <-readr::read_delim("course_proj_data.csv", 
                           ";", escape_double = FALSE, trim_ws = TRUE)
 
 attach(Data) # tres important pour garder mon data dans mon env de developpement
  
  output$tableDT <- DT::renderDataTable(DT::datatable(Data)%>%
                                          formatCurrency("MarketCap_in_M", "$", digit =0)%>%
                                          formatStyle("Symbol",
                                                      color="red")%>%
                                          formatStyle(c("G3","G2","G1"),
                                                      backgroundColor = "lighblue"))

# clé incontournable ici est reactive!!!!
  weighted.Data = reactive(

    cbind(Data,
          Estimate_Weighted = G1*input$bins1+G2*input$bins2+G3*input$bins3)
  )

 output$distPlot <- renderPlot({
                                ggplot(weighted.Data(), aes(Estimate_Weighted,MarketCap_in_M)) + geom_point() + geom_smooth(method="lm")+ xlab("Your calculated score") + ylab("Market Capitalization in Million USD")
 })
 

 
  MCM <- reactive({
    
    user_brush <- input$user_brush
    sel <- brushedPoints(weighted.Data(), user_brush)
    return(sel)
    })
  
  output$table <- DT::renderDataTable(DT::datatable(MCM())%>%
                                        formatCurrency("MarketCap_in_M", "$", digit =0)%>%
                                        formatStyle("Symbol",
                                                    color="blue")%>%
                                        formatStyle(c("G3","G2","G1"),
                                                    backgroundColor = "lighblue"))
  
  output$mydownload = downloadHandler(
    filename = "select_miners.csv",
    content = function(file){
      write.csv(MCM(), file)
    }
  )
  ### Merci!!!!!
    
    

}