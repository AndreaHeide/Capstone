library(R.utils)
library(magrittr)
library(doParallel)

library(stringr)
library(dplyr)
library(plyr)
library(tidyr)
library(tidytext)
library(data.table)

## REWORK? If candiate is 4 gram, elsif cadidate is 3 gram  etc , collect at the end?
## get all top 5 first, count which are not null, combine? 





wordpred <- function(user_input){
        
        ## count number of words in string, set other variables
        wordnum <- str_count(user_input, "\\S+")
        fourfound <- 0
        trifound <- 0
        bifound <- 0
        predword3 <- predword3[0,]
        predword2 <- predword2[0,]
        predword1 <- predword1[0,]
        predwordcombi <- predwordcombi[0,]
        check4 <- 0
        check3 <- 0
        check2 <- 0
        wordprobs <- wordprobs[0, ]
        
        ## clean input
        user_input <- removeSpecialChars(user_input)
        user_input <- tolower(user_input)
        user_input <- gsub("\\s+"," ",user_input)
        
        
        ## if more than 3 truncate to three and find word in fourgrams
        
        if (wordnum >= 3) {
                input <- paste0(tail(strsplit(user_input, ' ')[[1]], 3), collapse = ' ')
                
               
                
                
                
                 wordprobs <- modfour_prob[trigram == input]
                fourfound <- nrow(wordprobs)
                if (fourfound > 5 ) {
                        predword <- wordprobs[order(fourprob, decreasing = TRUE), ]
                        predword <- wordprobs[1:5, word4]
                        return(predword)
                }
                      
                if (fourfound < 5) {
                        predword3 <- wordprobs[1:fourfound, word4]
                        check3 <- 5-fourfound
                                }        
                        
                        
                          
                }
        
        ## if not found or 2 words, seek in trigrams
       
         ## TO DO: lambda = 0.4 : implement multiple back off (0.4 * 0.4 etc)
        ## REWORK? If candiate is 4 gram, elsif cadidate is 3 gram  etc , collect at the end?
        
      ##  if ((wordnum == 2) | (fourfound == 0)) {
        if ((wordnum == 2) | (check3 < 5)) {
                input <- paste0(tail(strsplit(user_input, ' ')[[1]], 2), collapse = ' ')
                wordprobs <- modtri_prob[bigram == input]
                trifound <- nrow(wordprobs)
                if (trifound > 5 & check3 == 0) {
                        predword <- wordprobs[order(triprob, decreasing = TRUE), ]
                        predword <- wordprobs[1:5, word3]
                        return(predword)
                }  
                if (trifound > 0 & check3 > 0) {
                        predword <- wordprobs[order(triprob, decreasing = TRUE), ]
                        predword2 <- wordprobs[1:check3, word3]
                        predword2$triprob =  predword2$triprob * 0.4
                        predwordcombi <- rbind(predword3, predword2)        
                        
                
                         if (nrow(predwordcombi == 5)) {
                                return(predwordcobi)}
                         if (nrow(predwordcombi < 5)) {
                                 check2 <- 5-(nrow(predwordcombi))
                         }
                }
        
        if ((wordnum == 1) | (trifound == 0) | check2 > 0) {
                input <- paste0(tail(strsplit(user_input, ' ')[[1]], 1), collapse = ' ')
                wordprobs <- modbi_prob[word1 == input]
                bifound <- nrow(wordprobs)
                if (bifound > 0 & check2 == 0) {   
                        predword <- wordprobs[order(biprob, decreasing = TRUE), ]
                        predword <- wordprobs[1:5, word2]
                        return(predword)
                }
                
                 if (bifound > 0 & check2 > 0) {
                        predword <- wordprobs[order(biprob, decreasing = TRUE), ]
                        predword1 <- wordprobs[1:5, word2]
                        predword1$biprob =  predword1$biprob * 0.4 * 0.4
                        predword <- rbind(predwordcombi, predword1)
                        return(predwordcombi)
                }                    
                
        }
        
        ## else find most probable word in unigrams
        if ((wordnum == 1) & (bifound == 0)) {
                        predword <-moduni_count[order(uniprob, decreasing = TRUE),  ]
                        predword <- wordprobs[1:5, word]
                }                    
                
        }
        
        return(predword)
        
}