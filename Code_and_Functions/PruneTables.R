## leave out the smallest probabilities
## cut off point: 0.001
## 
test <- nrow(modbi_prob[modbi_prob$biprob < 0.0005, ])

head(modbi_prob[order(biprob)])

modbi_prob <- modbi_prob[modbi_prob$biprob >= 0.001, ]
modtri_prob <- modtri_prob[modtri_prob$triprob >= 0.001, ]
modfour_prob <- modfour_prob[modfour_prob$fourprob >= 0.001, ]

## write
write.csv(modbi_prob, "modbi_prob.csv", quote = FALSE, row.names = FALSE)
write.csv(modtri_prob, "modtri_prob.csv", quote = FALSE, row.names = FALSE)
write.csv(modfour_prob, "modfour_prob.csv", quote = FALSE, row.names = FALSE) 