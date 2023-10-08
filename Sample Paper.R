data <- read.csv(file.choose(), header = T)
summary(data)
str(data)
library(plyr)
unique(data$Influencer)

data$Influencer <- revalue(data$Influencer, c("MEGA" = "Mega"))
data$Influencer <- revalue(data$Influencer, c("Mecro" = "Macro"))
data$Influencer <- revalue(data$Influencer, c("mecro" = "Macro"))
data$Influencer <- revalue(data$Influencer, c("makro" = "Macro"))
data$Influencer <- revalue(data$Influencer, c("macro" = "Macro"))
data$Influencer <- revalue(data$Influencer, c("Microh" = "Micro"))
data$Influencer <- revalue(data$Influencer, c("micro" = "Micro"))
data$Influencer <- revalue(data$Influencer, c("NANO" = "Nano"))
data$Influencer <- revalue(data$Influencer, c("nano" = "Nano"))
data$Influencer <- revalue(data$Influencer, c("Neno" = "Nano"))
data$Influencer <- revalue(data$Influencer, c(",meg" = "Mega"))
data$Influencer <- revalue(data$Influencer, c("maga" = "Mega"))
data$Influencer <- revalue(data$Influencer, c("meGA" = "Mega"))

data$Influencer <- as.factor(data$Influencer)

sum(is.na(data))
percent_MD <- function(x) { sum(is.na(x))/length(x) * 100}
apply(data, 2, percent_MD)



library(mice)

impute <- mice(data[], m =3, seed =123)
print(impute)

a <- impute$imp$TV
b <- impute$imp$Radio
c <- impute$imp$TikTok

completedata <- complete(impute, 2)

sum(is.na(completedata))
impute <- mice(completedata[], m =3, seed =123)
print(impute)
sum(is.na(completedata))

library(sqldf)
library(dplyr)

#1
q1 <- sqldf("SELECT* from completedata where Influencer = 'Mega' order by Sales desc")
completedata %>%
  filter(Influencer == 'Mega', Sales == max(Sales))

#2

ab <- completedata %>%
  group_by(Influencer) %>%
  summarise(Avg_sales = mean(Sales))
completedata %>%
  filter(Influencer == "Macro") %>%
  summarise(Avg_TikTok = mean(TikTok))

#3
#What is the average budget spent on all 
#the four types of influencers across all media platforms?

completedata%>%
  group_by(Influencer)%>%
  mutate(TotalBudget = mean(sum(TV, Radio, TikTok)))%>%
  summarise(AverageBudget = mean(TotalBudget))

#4
library(ggplot2)
completedata %>%
  ggplot(aes(TV, Sales))+
  geom_point(color = 'black')+
  geom_smooth(se= 0, method = "lm")%>%
  facet_wrap(Influencer)

completedata%>%
  ggplot(aes(TikTok, Sales))+
  geom_point(color = 'Black')+
  geom_smooth(se= 0, method = "lm")

