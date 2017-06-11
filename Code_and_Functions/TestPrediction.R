## test with quiz questions
## TO DO: generate tests to make a statement about accuracy
## (in % of cases the correct word is among the top 5)
## 


removeSpecialChars <- function(x) gsub("[^a-zA-Z ']","",x)
## read in test sets 

blog_lines <- readLines("/Users/Andrea/Desktop/DataScience/Capstone/final/en_US/en_US.blogs.txt")

test_lines <- readLines("/Users/Andrea/Desktop/DataScience/Capstone/test/testtext.txt")

set.seed(1212)
blog_test <-sample(blog_lines, NROW(blog_lines) * 0.05)

blog_test <- removeSpecialChars(blog_test)
blog_test <- removeSpecialChars(test_lines)
blog_test <- removeSpecialChars(quiz1)

blog_test <- data.table(text = blog_test)
blog_test <- set_names(blog_test, "test")

## get first 4 words of each line
croptext <- function(input) paste0(head(strsplit(input, ' ')[[1]], 4), collapse =' ')
blog_test$input <- sapply( blog_test$test, FUN = croptext)

## to compare later, get first 5 words 
croptext <- function(input) paste0(head(strsplit(input, ' ')[[1]], 5), collapse =' ')
blog_test$check <- sapply( blog_test$test, FUN = croptext)

## remove full text 
blog_test <- data.table(input = blog_test$input, check = blog_test$check)

## add check word as last word from check 
croptext <- function(input) paste0(tail(strsplit(input, ' ')[[1]], 1), collapse =' ')
blog_test$check_word <- sapply( blog_test$check, FUN = croptext)

## add column for result check
blog_test$result <- FALSE


## getgrams with blog_test$input as input 
for (i in 1: 10000) {
        results <- getgrams(blog_test[i, 1])    
        blog_test[i, 4] <- (blog_test[i, 3] %in% results$word) 
}

counttrue <- nrow(blog_test[blog_test$result == TRUE, ])
rate <- counttrue/100 
##rate blog
##[1] 29.73

## 10 random blog sentences: 50%
## quiz 1: 40%
## quiz 2:



##quiz1 <- c("I'll be there for you, I'd live and I'd", "I asked about dessert and he started telling me about his", "I'd give anything to see arctic monkeys this", "and helps reduce your", "away from me but you hadn't time to take a", "a presentation of evidence, and a jury to settle the"," even hold an uneven number of bags of groceries in each", "Every inch of you is perfect from the bottom to the", "was filled with imagination and bruises from playing", "same people are in almost all of Adam Sandler's")
The guy in front of me just bought a pound of bacon, a bouquet, and a case of
You're the reason why I smile everyday. Can you follow me please? It would mean the
Hey sunshine, can you follow me and make me the
Very early observations on the Bills game: Offense still struggling but the
Go on a romantic date at the
Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my
Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some
After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little
Be grateful for the good times and keep the faith during the
If this isn't the cutest thing you've ever seen, then you must be


for (i in 1:10) {
        print(i)
        print(quiz1[i])
        quiz1answers <- getgrams(quiz1[i])
        
        
}
## quiz 1 in top 5: N, N, N, N, Y, Y, N, Y, N, N
## 
## 
## store tables as r object (?!), tipp, .Rds
## 
## 
## from playing basketball with