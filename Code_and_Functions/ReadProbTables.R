
## try R objects
##  Save multiple objects
## save(data1, data2, file = "data.RData")
# To load the data again
 ##load("data.RData")

save(moduni_count, modbi_prob, modtri_prob, modfour_prob, file = "prob_tables.RData")

start.time <- Sys.time()
load("prob_tables.RData")
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken


## Read prepared csv files  

start.time <- Sys.time()

## set directory
setwd("/Users/Andrea/Desktop/DataScience/Capstone/SaveFiles")

## READ csv files PROBS TOTAL

## delete probs < 0.001 (save old files)
## compare quiz scores

moduni_count <- read.csv("./moduni_count.csv", stringsAsFactors = FALSE)
moduni_count <- data.table(moduni_count)
## remove extra column
moduni_count <- moduni_count[, c("n") := NULL]

modbi_prob <- read.csv("./modbi_prob.csv", stringsAsFactors = FALSE)
modbi_prob <- data.table(modbi_prob)

modtri_prob <- read.csv("./modtri_prob.csv", stringsAsFactors = FALSE)
modtri_prob <- data.table(modtri_prob)

modfour_prob <- read.csv("./modfour_prob.csv", stringsAsFactors = FALSE)
modfour_prob <- data.table(modfour_prob)

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
## 35 sec

## READ csv files BLOG
blog_unicount <- read.csv("./blog_unicount.csv", stringsAsFactors = FALSE)
blog_unicount <- data.table(blog_unicount)

news_bigramcount <- read.csv("./news_bigramcount.csv", stringsAsFactors = FALSE)
news_bigramcount <- data.table(news_bigramcount) 

news_bigramcount <- read.csv("./news_bigramcount.csv", stringsAsFactors = FALSE)
news_bigramcount <- data.table(news_bigramcount) 

news_trigramcount <- read.csv("./news_trigramcount.csv", stringsAsFactors = FALSE)
news_trigramcount <- data.table(news_trigramcount) 

news_fourgramcount <- read.csv("./news_fourgramcount.csv", stringsAsFactors = FALSE)
news_fourgramcount <- data.table(news_fourgramcount) 

## READ csv files NEWS
news_unicount <- read.csv("./news_unicount.csv", stringsAsFactors = FALSE)
news_unicount <- data.table(news_unicount)

news_bigramcount <- read.csv("./news_bigramcount.csv", stringsAsFactors = FALSE)
news_bigramcount <- data.table(news_bigramcount) 

news_bigramcount <- read.csv("./news_bigramcount.csv", stringsAsFactors = FALSE)
news_bigramcount <- data.table(news_bigramcount) 

news_trigramcount <- read.csv("./news_trigramcount.csv", stringsAsFactors = FALSE)
news_trigramcount <- data.table(news_trigramcount) 

news_fourgramcount <- read.csv("./news_fourgramcount.csv", stringsAsFactors = FALSE)
news_fourgramcount <- data.table(news_fourgramcount) 




