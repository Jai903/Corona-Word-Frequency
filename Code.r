library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(dplyr)

#connect to twitter
setup_twitter_oauth(ckey,cskey,token,sectoken)

##search twitter
corona.tweets<-searchTwitter('corona',n=2000,lang='en')
help("searchTwitteR")
corona.text<-sapply(corona.tweets,function(x)x$getText())

###Clean Data
corona.text<-iconv(corona.text,'UTF-8','ASCII')
corona.corpus<-Corpus(VectorSource(corona.text))

#### Document Term Matrix
term.matrix<-TermDocumentMatrix(corona.corpus,
                                control=list(removePunctuation=T,
                                             stopwords=c('corona','httpstcocjzsodengq','httpstcocjzsodengq',stopwords('english')),
                                             removeNumbers=T,
                                             tolower=T))

##### Convert into matrix
term.matrix<-as.matrix(term.matrix)

##Give word counts
word.count<-sort(rowSums(term.matrix),decreasing = T)
dm<-data.frame(word=names(word.count),frequency=word.count)

# Create word cloud
wordcloud(dm$word,dm$frequency,random.order = F,colors=brewer.pal(8,'Dark2'))
