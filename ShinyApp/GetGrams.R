## get matches from all ngram tables

library(R.utils)
library(magrittr)
library(doParallel)

library(stringr)
library(dplyr)
library(plyr)
library(tidyr)
library(tidytext)
library(data.table)

## Clean function
removeSpecialChars <- function(x) gsub("[^a-zA-Z ']","",x)

## helper function
`%notin%` <- function(x,y) !(x %in% y) 


getgrams <- function(input){
        
## suppress warnings temporarily
        oldw <- getOption("warn")
        options(warn = -1)
        
        
## initiate empty
        wordprobs <- data.table()       
        predwords4 <- data.table()  
        countrecords4 <- 0 
        predwords3 <- data.table() 
        countrecords3 <- 0
        predwords2 <- data.table() 
        countrecords2 <- 0
        predwords1 <- data.table() 
        predresult <- data.table() 
        
        ## clean input
        input <- removeSpecialChars(input)
        input <- tolower(input)
        input <- gsub("\\s+"," ",input)
        
        ## count number of words in string
        wordnum <- str_count(input, "\\S+")
        
        ## prediction function
        if (wordnum >= 3) {
                ## get results from all tables with stupid backoff
                ## fourgrams
                
                input <- paste0(tail(strsplit(input, ' ')[[1]], 3), collapse =' ')
                
                 wordprobs <- modfour_prob[trigram == input]
                 wordprobs <- wordprobs[order(fourprob, decreasing = TRUE), ]
                 if (nrow(wordprobs) > 0) {
                        predwords4 <- wordprobs[1:5,  2:3]
                        predwords4 <- set_names(predwords4, c("word", "prob"))
                 }
                 
                ## trigrams
                 input <- paste0(tail(strsplit(input, ' ')[[1]], 2), collapse = ' ')
                 wordprobs <- modtri_prob[bigram == input] 
                 wordprobs <- wordprobs[wordprobs$word3 %notin% predwords4$word ]   
                 wordprobs <- wordprobs[order(triprob, decreasing = TRUE), ]
                 if (nrow(wordprobs) > 0) {
                        predwords3 <- wordprobs[1:5, 2:3]
                        predwords3$triprob <- predwords3$triprob * 0.4
                        predwords3 <- set_names(predwords3, c("word", "prob"))
                 }
                 
                 ## bigrams
                 input <- paste0(tail(strsplit(input, ' ')[[1]], 1), collapse = ' ')
                 wordprobs <- modbi_prob[word1 == input]
                 wordprobs <- wordprobs[(wordprobs$word2 %notin% predwords3$word) & (wordprobs$word2 %notin% predwords4$word) ]
                 wordprobs <- wordprobs[order(biprob, decreasing = TRUE), ]
                 if (nrow(wordprobs) > 0) {
                        predwords2 <- wordprobs[1:5, 2:3 ]
                        predwords2$biprob <- predwords2$biprob * 0.4 * 0.4
                        predwords2 <- set_names(predwords2, c("word", "prob"))
                 }
        }
        
        if (wordnum == 2) {
                
                ## trigrams
                wordprobs <- modtri_prob[bigram == input] 
                wordprobs <- wordprobs[order(triprob, decreasing = TRUE), ]
                if (nrow(wordprobs) > 0) {
                        predwords3 <- wordprobs[1:5, 2:3 ]
                        predwords3 <- set_names(predwords3, c("word", "prob"))
                }
                
                ## bigrams
                input <- paste0(tail(strsplit(input, ' ')[[1]], 1), collapse = ' ')
                wordprobs <- modbi_prob[word1 == input] 
                wordprobs <- wordprobs[wordprobs$word2 %notin% predwords3$word ]
                wordprobs <- wordprobs[order(biprob, decreasing = TRUE), ]
                if (nrow(wordprobs) > 0) {
                        predwords2 <- wordprobs[1:5, 2:3 ]
                        predwords2$biprob <- predwords2$biprob * 0.4 
                        predwords2 <- set_names(predwords2, c("word", "prob"))
                }
        }
         
        if (wordnum == 1) {
                
                ## bigrams
                wordprobs <- modbi_prob[word1 == input] 
                wordprobs <- wordprobs[order(biprob, decreasing = TRUE), ]
                if (nrow(wordprobs) > 0) {
                        predwords2 <- wordprobs[1:5, 2:3 ]
                        predwords2 <- set_names(predwords2, c("word", "prob"))
                }
        }        
    
            
        ## Combine output (5 highest probs)
        countrecords4 <-  nrow(predwords4[!is.na(predwords4$prob), ])
        countrecords3 <-  nrow(predwords3[!is.na(predwords3$prob), ])
        countrecords2 <-  nrow(predwords2[!is.na(predwords2$prob), ])
         
        if (countrecords4 > 0) {
        predresult <- rbind(predwords4[1:countrecords4, ], 
                            predwords3[1:countrecords3, ],
                            predwords2[1:countrecords2, ]
                            )
        }
        if (countrecords4 == 0 & countrecords3 > 0) {
                predresult <- rbind(predwords3[1:countrecords3, ],
                                    predwords2[1:countrecords2, ]
                )        
        }
        if (countrecords3 == 0 & countrecords2 >0) {
                predresult <- predwords2[1:countrecords2, ]        
        }
        
        if (countrecords2 == 0) {
                ## use unigrams
                predwords1 <- moduni_count[order(uniprob, decreasing = TRUE)]
                predwords1 <- predwords1[1:5, 1:2 ]
                predwords1$uniprob <- predwords1$uniprob * 0.4 * 0.4
                predwords1 <- set_names(predwords1, c("word", "prob"))
                predresult <- predwords1
                return(predresult)
        }
        
        predresult <- predresult[order(-prob)]
        predresult <- predresult[1:5, ]
        
        ##  use unigrams to fill up 5 records
        if (nrow(predresult) < 5) {
                
                predwords1 <- moduni_count[order(uniprob, decreasing = TRUE)]
                predwords1 <- predwords1[1:(5 - nrow(predresult)),  ]
                predwords1$uniprob <- predwords1$uniprob * 0.4 * 0.4
                predwords1 <- set_names(predwords1, c("word", "prob"))
                
                predresult <-  rbind(predresult, predwords1) 
        }
        
        return(predresult)
        
## turn warnings on again        
        options(warn = oldw)        
}