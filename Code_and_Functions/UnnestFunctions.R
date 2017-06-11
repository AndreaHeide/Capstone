## object.size(): this function reports the number of bytes that an R object occupies in memory
## Rprof(): this function runs the profiler in R that can be used to determine where bottlenecks 
##in your function may exist. The profr package (available on CRAN) provides some additional tools 
##for visualizing and summarizing profiling data.
## gc(): this function runs the garbage collector to retrieve unused RAM for R. 
##In the process it tells you how much memory is currently being used by R.



## BLOG

## unigrams blog
task_uni_blog <- function() {unnest_tokens(blog_tbl, unigram, text, token = "words")}
blog_unigrams <- parallelizeTask(task_uni_blog)
blog_unigrams <- data.table(blog_unigrams)

remove(blog_lines_clean)
remove(blog_lines)

## counting unigrams blog
task_blog_unicount <-function() { dplyr::count(blog_unigrams, unigram, wt = NULL, sort = TRUE)}
blog_unicount <- parallelizeTask(task_blog_unicount)
blog_unicount <- data.table(blog_unicount)
## leave count 1
blog_unicount <- blog_unicount[blog_unicount$n > 1, ]
## write and remove excess tables
write.csv(blog_unicount, "blog_unicount.csv", quote = FALSE, row.names = FALSE)
remove(blog_unigrams)

## bigrams blog
task_bi_blog <- function() {unnest_tokens(blog_tbl, bigram, text, token = "ngrams", n = 2)}
blog_bigrams <- parallelizeTask(task_bi_blog)
blog_bigrams <- data.table(blog_bigrams)

task_bi_blog_count <- function() {dplyr::count(blog_bigrams, bigram, wt = NULL, sort = TRUE)}
blog_bigramcount <- parallelizeTask(task_bi_blog_count)
## leave count 1
blog_bigramcount <- blog_bigramcount[blog_bigramcount$n > 1, ]
## write and remove excess tables
write.csv(blog_bigramcount, "blog_bigramcount.csv", quote = FALSE, row.names = FALSE)
remove(blog_bigrams)

## trigrams blog
task_tri_blog <- function() {unnest_tokens(blog_tbl, trigram, text, token = "ngrams", n = 3)}
blog_trigrams <- parallelizeTask(task_tri_blog)
blog_trigrams <- data.table(blog_trigrams)

task_tri_blog_count <- function(){dplyr::count(blog_trigrams, trigram, wt = NULL, sort = TRUE)}
blog_trigramcount <- parallelizeTask(task_tri_blog_count)
blog_trigramcount <- data.table(blog_trigramcount)

## leave out 3grams with count 1
blog_trigramcount <- blog_trigramcount[blog_trigramcount$n > 1, ]

write.csv(blog_trigramcount, "blog_trigramcount.csv", quote = FALSE, row.names = FALSE)
remove(blog_trigrams)


## fourgrams blog
task_four_blog <- function() {unnest_tokens(blog_tbl, fourgram, text, token = "ngrams", n = 4)}
blog_fourgrams <- parallelizeTask(task_four_blog)
blog_fourgrams <- data.table(blog_fourgrams)

task_four_blog_count <- function(){dplyr::count(blog_fourgrams, fourgram, wt = NULL, sort = TRUE)}
blog_fourgramcount <- parallelizeTask(task_four_blog_count)
blog_fourgramcount <- data.table(blog_fourgramcount)

## leave out 4grams with count 1
blog_fourgramcount <- blog_fourgramcount[blog_fourgramcount$n > 1, ]

write.csv(blog_fourgramcount, "blog_fourgramcount.csv", quote = FALSE, row.names = FALSE)
remove(blog_fourgrams)

remove(blog_tbl)


## NEWS

## unigrams news
task_uni_news <- function() {unnest_tokens(news_tbl, unigram, text, token = "words")}
news_unigrams <- parallelizeTask(task_uni_news)
news_unigrams <- data.table(news_unigrams)

remove(news_lines_clean)
remove(news_lines)

## counting unigrams news
task_news_unicount <-function() { dplyr::count(news_unigrams, unigram, wt = NULL, sort = TRUE)}
news_unicount <- parallelizeTask(task_news_unicount)
news_unicount <- data.table(news_unicount)
## leave count 1
news_unicount <- news_unicount[news_unicount$n > 1, ]
## write and remove excess tables
write.csv(news_unicount, "news_unicount.csv", quote = FALSE, row.names = FALSE)
remove(news_unigrams)

## bigrams news
task_bi_news <- function() {unnest_tokens(news_tbl, bigram, text, token = "ngrams", n = 2)}
news_bigrams <- parallelizeTask(task_bi_news)
news_bigrams <- data.table(news_bigrams)

task_bi_news_count <- function() {dplyr::count(news_bigrams, bigram, wt = NULL, sort = TRUE)}
news_bigramcount <- parallelizeTask(task_bi_news_count)
## leave count 1
news_bigramcount <- news_bigramcount[news_bigramcount$n > 1, ]
## write and remove excess tables
write.csv(news_bigramcount, "news_bigramcount.csv", quote = FALSE, row.names = FALSE)
remove(news_bigrams)

## trigrams news
task_tri_news <- function() {unnest_tokens(news_tbl, trigram, text, token = "ngrams", n = 3)}
news_trigrams <- parallelizeTask(task_tri_news)
news_trigrams <- data.table(news_trigrams)

task_tri_news_count <- function(){dplyr::count(news_trigrams, trigram, wt = NULL, sort = TRUE)}
news_trigramcount <- parallelizeTask(task_tri_news_count)
news_trigramcount <- data.table(news_trigramcount)

## leave out 3grams with count 1
news_trigramcount <- news_trigramcount[news_trigramcount$n > 1, ]

write.csv(news_trigramcount, "news_trigramcount.csv", quote = FALSE, row.names = FALSE)
remove(news_trigrams)


## fourgrams news
task_four_news <- function() {unnest_tokens(news_tbl, fourgram, text, token = "ngrams", n = 4)}
news_fourgrams <- parallelizeTask(task_four_news)
news_fourgrams <- data.table(news_fourgrams)

task_four_news_count <- function(){dplyr::count(news_fourgrams, fourgram, wt = NULL, sort = TRUE)}
news_fourgramcount <- parallelizeTask(task_four_news_count)
news_fourgramcount <- data.table(news_fourgramcount)

## leave out 4grams with count 1
news_fourgramcount <- news_fourgramcount[news_fourgramcount$n > 1, ]

write.csv(news_fourgramcount, "news_fourgramcount.csv", quote = FALSE, row.names = FALSE)
remove(news_fourgrams)

remove(news_tbl)

## TWITTER

## unigrams twitter
task_uni_twitter <- function() {unnest_tokens(twitter_tbl, unigram, text, token = "words")}
twitter_unigrams <- parallelizeTask(task_uni_twitter)
twitter_unigrams <- data.table(twitter_unigrams)

remove(twitter_lines_clean)
remove(twitter_lines)

## counting unigrams twitter
task_twitter_unicount <-function() { dplyr::count(twitter_unigrams, unigram, wt = NULL, sort = TRUE)}
twitter_unicount <- parallelizeTask(task_twitter_unicount)
twitter_unicount <- data.table(twitter_unicount)
## leave count 1
twitter_unicount <- twitter_unicount[twitter_unicount$n > 1, ]
## write and remove excess tables
write.csv(twitter_unicount, "twitter_unicount.csv", quote = FALSE, row.names = FALSE)
remove(twitter_unigrams)

## bigrams twitter
task_bi_twitter <- function() {unnest_tokens(twitter_tbl, bigram, text, token = "ngrams", n = 2)}
twitter_bigrams <- parallelizeTask(task_bi_twitter)
twitter_bigrams <- data.table(twitter_bigrams)

task_bi_twitter_count <- function() {dplyr::count(twitter_bigrams, bigram, wt = NULL, sort = TRUE)}
twitter_bigramcount <- parallelizeTask(task_bi_twitter_count)
## leave count 1
twitter_bigramcount <- twitter_bigramcount[twitter_bigramcount$n > 1, ]
## write and remove excess tables
write.csv(twitter_bigramcount, "twitter_bigramcount.csv", quote = FALSE, row.names = FALSE)
remove(twitter_bigrams)

## trigrams twitter
task_tri_twitter <- function() {unnest_tokens(twitter_tbl, trigram, text, token = "ngrams", n = 3)}
twitter_trigrams <- parallelizeTask(task_tri_twitter)
twitter_trigrams <- data.table(twitter_trigrams)

task_tri_twitter_count <- function(){dplyr::count(twitter_trigrams, trigram, wt = NULL, sort = TRUE)}
twitter_trigramcount <- parallelizeTask(task_tri_twitter_count)
twitter_trigramcount <- data.table(twitter_trigramcount)

## leave out 3grams with count 1
twitter_trigramcount <- twitter_trigramcount[twitter_trigramcount$n > 1, ]

write.csv(twitter_trigramcount, "twitter_trigramcount.csv", quote = FALSE, row.names = FALSE)
remove(twitter_trigrams)

## fourgrams twitter
task_four_twitter <- function() {unnest_tokens(twitter_tbl, fourgram, text, token = "ngrams", n = 4)}
twitter_fourgrams <- parallelizeTask(task_four_twitter)
twitter_fourgrams <- data.table(twitter_fourgrams)

task_four_twitter_count <- function(){dplyr::count(twitter_fourgrams, fourgram, wt = NULL, sort = TRUE)}
twitter_fourgramcount <- parallelizeTask(task_four_twitter_count)
twitter_fourgramcount <- data.table(twitter_fourgramcount)

## leave out 4grams with count 1
twitter_fourgramcount <- twitter_fourgramcount[twitter_fourgramcount$n > 1, ]

write.csv(twitter_fourgramcount, "twitter_fourgramcount.csv", quote = FALSE, row.names = FALSE)
remove(twitter_fourgrams)

remove(twitter_tbl)
