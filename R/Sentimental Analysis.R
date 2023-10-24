#Import Data
Apple<- read.csv(file.choose(), header = T)


library("tm")
library("wordcloud")
library("syuzhet")
library("lubridate")
library("scales")
library("reshape2")

#easy text read
convert <- iconv(Apple$text, to = "utf-8")

#Obtain sentiment score
s<- get_nrc_sentiment(convert)

# Look at the first 6 rows
head(s)

#Open up a selected row data to investigate
convert[4]

#Looking at dictionary and the sentiment associated 
get_nrc_sentiment("Ugly")

#Creating a barplot to understand the freq of sentiment
barplot(colSums(s),
        las=2,
        col = rainbow(10),
        ylab= "Count",
        xlab = "Sentiment",
        main= "Sentiment Analysis")
############################################################################
#Now we will analyze the data post EPS

Apple2<- read.csv(file.choose(), header = T)
convert <- iconv(Apple2$text, to = "utf-8")
s2<- get_nrc_sentiment(convert)

barplot(colSums(s2),
        las=2,
        col = rainbow(10),
        ylab= "Count",
        xlab = "Sentiment",
        main= "Sentiment Analysis post EPS")
