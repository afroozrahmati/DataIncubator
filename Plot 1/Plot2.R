library(ggplot2)   

# The list of valid books
books <<- list("myocardial infarction in 1990" = "MI_1990",
               "myocardial infarction in 1995" = "MI_1995",
               "myocardial infarction in 2000" = "MI_2000",
               "myocardial infarction in 2005" = "MI_2005",
               "myocardial infarction in 2010" = "MI_2010",
               "myocardial infarction in 2011" = "MI_2011",
               "myocardial infarction in 2012" = "MI_2012",
               "myocardial infarction in 2013" = "MI_2013",
               "myocardial infarction in 2014" = "MI_2014",
               "myocardial infarction in 2015" = "MI_2015")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")
  
  MI <- read.csv(sprintf("./%s.csv", book),
                 encoding="UTF-8")
  
  (myCorpus = Corpus(VectorSource(MI$concept)))
  
  myDTM = TermDocumentMatrix(myCorpus,control = list(minWordLength = 1))
  dtms <- removeSparseTerms(myDTM, 0.1)
  freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
  wf <- data.frame(word=names(freq), freq=freq) 
  p <- ggplot(subset(wf, freq>50), aes(word, freq))    
  p <- p + geom_bar(stat="identity")   
  p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))   
  p  
})