#install.packages("wordcloud")
library('tm')
library("wordcloud")
#clean environment 
rm(list=ls())
#set working directory
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\Lab 8 - Text Analytics")

##########################
#req1
dfm <- read.csv("movie_reviews.csv")
##########################
#req2
dfm
dim(dfm)
##########################
#req3
pcorpus <- Corpus(VectorSource(dfm$text))
##########################
#req4
pcorpus <- tm_map(pcorpus, tolower)
##########################
#req5
#getTransformations()
inspect(pcorpus[940])
pcorpus <- tm_map(pcorpus, removeNumbers)
inspect(pcorpus[940])
pcorpus <- tm_map(pcorpus, removePunctuation)
inspect(pcorpus[940])
pcorpus <- tm_map(pcorpus, stripWhitespace)
inspect(pcorpus[940])
##########################
#req6
pcorpus <- tm_map(pcorpus,removeWords, stopwords("english"))
inspect(pcorpus[940])
##########################
#req7
pdtm <- DocumentTermMatrix(pcorpus)
##########################
#req8
inspect(pdtm)
#Sparsity : 100% #??modify

#Non-/sparse entries: 689184/3006202016
#Sparsity = 300620201600/(3006202016 + 689184)
dim(pdtm)
##########################
#req9
pdtm <- removeSparseTerms(pdtm, 0.9999)
#ignoring terms that have a document frequency lower than a given threshold
#doc freq = #doc containing the word/total #docs
str(inspect(pdtm))
#########################
#req10
pfreq <- findFreqTerms(pdtm, 65)
pfreq
#########################
#req11
movie_assoc <- findAssocs(pdtm, "titanic", 0.05)
movie_assoc
live_assoc <- findAssocs(pdtm, "marvel", 0.05)
live_assoc
#######################
#req12
pdtm <- removeSparseTerms(pdtm, 0.999)
#########################
#req13
pdtm2 <- as.matrix(pdtm)
pdtm2
pfrequency <- colSums(pdtm2)
pfrequency
pfrequency <- sort(pfrequency, decreasing = TRUE)
pfrequency
#########################
#req14
pfrequency[1:5]
#########################
#req15
pwords <- names(pfrequency[1:100])
wordcloud(pwords, pfrequency[1:100],colors = c("chartreuse", "cornflowerblue", "darkorange"))