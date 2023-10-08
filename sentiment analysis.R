#sentiment analysis
install.packages("syuzhet")
install.packages("lubridate")
install.packages("scales")
install.packages("reshape2")

library(syuzhet)
library(lubridate)
library(scales)
library(reshape2)
library(dplyr)

#file
apple <- read.csv(file.choose(), header = T)
tweets <- iconv(apple$text, to = "utf-8")

#obtain sentiment scores
s1 <- get_nrc_sentiment(tweets)
head(s)

#Barplot
barplot(colSums(s1), las = 2, col = rainbow(10), ylab = 'Count',
        main = "Sentiment Scores for Apple Tweets post - EPS")
