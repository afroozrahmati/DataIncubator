library(shiny)
library(ggplot2)
library(tm)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    MI <- read.csv("MI_2012.csv",encoding="UTF-8")
    (myCorpus = Corpus(VectorSource(MI$concept)))
    dtm <- DocumentTermMatrix(myCorpus)  
    freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
    wf <- data.frame(word=names(freq), freq=freq) 
    p <- ggplot(subset(wf, freq>50), aes(word, freq))    
    p <- p + geom_bar(stat="identity")   
    p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
    p 
  
  })
  
})