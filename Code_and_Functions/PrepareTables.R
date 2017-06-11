## Prepare tables with ngrams for model

## YET TO DO: remove lowest probabilities for speed (time loading process)

## combining
combi_unicount <- rbind(blog_unicount, news_unicount)
remove(blog_unicount)
remove(news_unicount)
moduni_count <- rbind(combi_unicount, twitter_unicount)
remove(combi_unicount)
remove(twitter_unicount)

combi_bigramcount <- rbind(blog_bigramcount, news_bigramcount)
remove(blog_bigramcount)
remove(news_bigramcount)
modbi_count <- rbind(combi_bigramcount, twitter_bigramcount)
remove(combi_bigramcount)
remove(twitter_bigramcount)

combi_trigramcount <- rbind(blog_trigramcount, news_trigramcount)
remove(blog_trigramcount)
remove(news_trigramcount)
modtri_count <- rbind(combi_trigramcount, twitter_trigramcount)
remove(combi_trigramcount)
remove(twitter_trigramcount)

combi_fourgramcount <- rbind(blog_fourgramcount, news_fourgramcount)
remove(blog_fourgramcount)
remove(news_fourgramcount)
modfour_count <- rbind(combi_fourgramcount, twitter_fourgramcount)
remove(combi_fourgramcount)
remove(twitter_fourgramcount)


## sum up counts
combi_unicount <- combi_unicount[,list(n=sum(n)),by=unigram]
combi_bigramcount <- combi_bigramcount[,list(n=sum(n)),by=bigram]
combi_trigramcount <- combi_trigramcount[,list(n=sum(n)),by=trigram]
combi_fourgramcount <- combi_fourgramcount[,list(n=sum(n)),by=fourgram]

moduni_count <- moduni_count[,list(n=sum(n)),by=unigram]
modbi_count <- modbi_count[,list(n=sum(n)),by=bigram]
modtri_count <- modtri_count[,list(n=sum(n)),by=trigram]
modfour_count <- modfour_count[,list(n=sum(n)),by=fourgram]

## write save
write.csv(combi_unicount, "combi_unicount.csv", quote = FALSE, row.names = FALSE)
write.csv(combi_bigramcount, "combi_bigramcount.csv", quote = FALSE, row.names = FALSE)
write.csv(combi_trigramcount, "combi_trigramcount.csv", quote = FALSE, row.names = FALSE)
write.csv(combi_fourgramcount, "combi_fourgramcount.csv", quote = FALSE, row.names = FALSE)

write.csv(moduni_count, "moduni_count.csv", quote = FALSE, row.names = FALSE)
write.csv(modbi_count, "modbi_count.csv", quote = FALSE, row.names = FALSE)
write.csv(modtri_count, "modtri_count.csv", quote = FALSE, row.names = FALSE)
write.csv(modfour_count, "modfour_count.csv", quote = FALSE, row.names = FALSE)

## add probabalilities to count tables
## uni: get count to calculate prob
blog_uni <- nrow(blog_unigrams) ##22091161
uni_blog_rows <- inner_join(blog_unigrams, blog_unicount, by = c("unigram" = "unigram") )
blog_uni <- nrow(uni_blog_rows) ## 21918826

uni_news1 <- news_unicount[news_unicount$n > 1, ] ## 106163
uni_news_rows <- inner_join(news_unigrams, uni_news1, by = c("unigram" = "unigram") )
news_uni <- nrow(uni_news_rows)  ##  13297761

uni_twitter_rows <- inner_join(twitter_unigrams, twitter_unicount, by = c("unigram" = "unigram") )
twitter_uni <- nrow(uni_twitter_rows) ##5764955

uni_rows <- blog_uni + news_uni + twitter_uni  ## 40981542

## ad prob uni
moduni_count$uniprob <- moduni_count$n / uni_rows 
write.csv(moduni_count, "moduni_count.csv", quote = FALSE, row.names = FALSE)


## bi
modbi_sep <- modbi_count %>% separate(bigram, c("word1", "word2"), sep = " ")
modbi_prob <- left_join(modbi_sep, moduni_count, by = c("word1" = "unigram"))
modbi_prob$biprob <- modbi_prob$n.x / modbi_prob$n.y
modbi_prob <- data.table(modbi_prob)
## remove extra columns
modbi_prob <- modbi_prob[, c("n.x", "n.y", "uniprob") := NULL]
remove(modbi_sep)
write.csv(modbi_prob, "modbi_prob.csv", quote = FALSE, row.names = FALSE)

## tri
modtri_sep <- modtri_count %>% separate(trigram, c("word1", "word2", "word3"), sep = " ")
modtri_sep <- modtri_sep %>% unite(bigram, word1, word2, sep = " ")
modtri_prob <- left_join(modtri_sep, modbi_count, by = c("bigram" = "bigram") )
modtri_prob$triprob <- modtri_prob$n.x / modtri_prob$n.y
modtri_prob <- data.table(modtri_prob)
## remove extra columns
remove(modtri_sep)
modtri_prob <- modtri_prob[, c("n.x", "n.y") := NULL]
write.csv(modtri_prob, "modtri_prob.csv", quote = FALSE, row.names = FALSE)


## four
modfour_sep <- modfour_count %>% separate(fourgram, c("word1", "word2", "word3", "word4"), sep = " ")
modfour_sep <- modfour_sep %>% unite(trigram, word1, word2, word3, sep = " ")
modfour_prob <- left_join(modfour_sep, modtri_count, by = c("trigram" = "trigram") )
modfour_prob$fourprob <- modfour_prob$n.x / modfour_prob$n.y
modfour_prob <- data.table(modfour_prob)

## remove extra columns
remove(modfour_sep)
remove(modtri_count)
remove(modfour_count)
modfour_prob <- modfour_prob[, c("n.x", "n.y") := NULL]
write.csv(modfour_prob, "modfour_prob.csv", quote = FALSE, row.names = FALSE)


## idea: sort within prob table by first word for speed?

