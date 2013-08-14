#set wd
#load packages

library("rJava")
library("rWeka")
library("Snowball")
library("stringr")
library("tm")

#read file
apr30.df <- read.csv("april 30.csv", header=TRUE, sep=",")

#check out first two items
apr30.df[1:2,]
#check it out more
summary(apr30.df)

#isolate text portion
txtapr30.df <- apr30.df[1,]

#turn into corpus
apr30.corpus <- Corpus(DataframeSource(data.frame(txtapr30.df)))

apr30.corpus <- tm_map(apr30.corpus, tolower)
apr30.corpus <- tm_map(apr30.corpus, function(x) removeWords(x, stopwords("english")))
apr30.corpus <- tm_map(apr30.corpus, stemDocument)
tdmapr30 <- TermDocumentMatrix(apr30.corpus)

inspect(tdmapr30[1:5, 100:105])


#to write term doc matrix
m <- inspect(tdm)
DF <- as.data.frame(m, stringsAsFactors = FALSE)
write.table(DF)

#Reduce size by filtering first for keyword
#Now working with a different corpus
dellTweets <- tm_filter(apr1.corpus, pattern = "dell")
#stop and inspect dellTweets
dellTweets
#create tdm
tdmDell <- TermDocumentMatrix(dellTweets)

#finds number of times terms are mentioned 
tdmDell.m <- as.matrix(tdmDell, row.names=TRUE)
v1<- sort(rowSums(tdmDell.m),decreasing=TRUE)
#inspect
v1
