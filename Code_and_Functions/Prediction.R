library(R.utils)
library(magrittr)
library(doParallel)

library(stringr)
library(dplyr)
library(plyr)
library(tidyr)
library(tidytext)
library(data.table)

wordpred <- function(user_input){
        
        
        ## count number of words in string
        wordnum <- str_count(user_input, "\\S+")
        
        ## clean input
        user_input <- removeSpecialChars(user_input)
        user_input <- tolower(user_input)
        user_input <- gsub("\\s+"," ",user_input)
        
        ## get prediction (5 words)
        result <- getgrams(user_input)
        
        return(result)
        
        
}       
       