## Read lines as preparation

## set directory
setwd("/Users/Andrea/Desktop/DataScience/Capstone/SaveFiles")


## Clean function
removeSpecialChars <- function(x) gsub("[^a-zA-Z ']","",x)

## BLOG
blog_lines <- readLines("/Users/Andrea/Desktop/DataScience/Capstone/final/en_US/en_US.blogs.txt")
blog_lines_clean <- removeSpecialChars(blog_lines)

set.seed(1233)
blog_lines <-sample(blog_lines_clean, NROW(blog_lines_clean) * 0.6)
blog_tbl <- data.frame(text = blog_lines, stringsAsFactors = FALSE)


## NEWS
news_lines <- readLines("/Users/Andrea/Desktop/DataScience/Capstone/final/en_US/en_US.news.txt")
news_lines_clean <- removeSpecialChars(news_lines)

set.seed(1233)
news_lines <-sample(news_lines_clean, NROW(news_lines_clean) * 0.4)
news_tbl <- data.frame(text = news_lines, stringsAsFactors = FALSE)

## TWITTER

## twitter
twitter_lines <- readLines("/Users/Andrea/Desktop/DataScience/Capstone/final/en_US/en_US.twitter.txt")
twitter_lines_clean <- removeSpecialChars(twitter_lines)

set.seed(1233)
twitter_lines <-sample(twitter_lines_clean, NROW(twitter_lines_clean) * 0.2)
twitter_tbl <- data.frame(text = twitter_lines, stringsAsFactors = FALSE)


