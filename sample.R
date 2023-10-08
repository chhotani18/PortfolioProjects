install.packages("plyr")
library(plyr)
#Data

data <- read.csv(file.choose(), header = T)

#Missing Values
sum(is.na(data))

unique(data$top1)

#Data Cleaning
data$top1 <- revalue(data$top1, c("Tacobell" = "Taco Bell"))
data$top1 <- revalue(data$top1, c("Tacco bell" = "Taco Bell"))
data$top1 <- revalue(data$top1, c("In-n-out" = "In-N-Out"))
data$top1 <- revalue(data$top1, c("In-n-out Kebob Shop" = "In-N-Out"))
data$top1 <- revalue(data$top1, c("chik-fil-a" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("Chick fila" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("Chick-fil-a" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("chik-fil-a" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("Chick fil a" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("Chickfila" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("chickfila" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("Chick-Fil-A" = "Chick-fil-A"))
data$top1 <- revalue(data$top1, c("panera" = "Panera"))
data$top1 <- revalue(data$top1, c("Panera bread" = "Panera"))
data$top1 <- revalue(data$top1, c("panera bread" = "Panera"))
data$top1 <- revalue(data$top1, c("McDonalds" = "McDonald's"))
data$top1 <- revalue(data$top1, c("Mcdondalds" = "McDonald's"))
data$top1 <- revalue(data$top1, c("MacDonalds" = "McDonald's"))
data$top1 <- revalue(data$top1, c("mcdonalds" = "McDonald's"))
data$top1 <- revalue(data$top1, c("Mcdonalds" = "McDonald's"))
data$top1 <- revalue(data$top1, c("arbys" = "Arby's"))
data$top1 <- revalue(data$top1, c("Arbys" = "Arby's"))
data$top1 <- revalue(data$top1, c("Sub Way" = "Subway"))
data$top1 <- revalue(data$top1, c("Wendys" = "Wendy's"))
data$top1 <- revalue(data$top1, c("burger king" = "Burger King"))
data$top1 <- revalue(data$top1, c("Jasons Deli" = "Jason's Deli"))

table(data$top1)

data$top1 <- revalue(data$top1, c("Applebees" = "Others"))
data$top1 <- revalue(data$top1, c("Burger King" = "Others"))
data$top1 <- revalue(data$top1, c("Eppies" = "Others"))
data$top1 <- revalue(data$top1, c("Martins" = "Others"))
data$top1 <- revalue(data$top1, c("Outback" = "Others"))
data$top1 <- revalue(data$top1, c("Pizza express" = "Others"))
data$top1 <- revalue(data$top1, c("Pizza Hut" = "Others"))
data$top1 <- revalue(data$top1, c("The Market" = "Others"))

#Imputing for Missing Values
library(mice)
percent <- function(x) {sum(is.na(x))/length(x) *100}
apply(data, 2, percent)

#Change Character to Factor Variables
typeof(data$top1)
data$top1 <- as.factor(data$top1)

#Impute
impute <- mice(data, m = 3, seed = 123)
impute$imp$taco_bellhealthy
data[10,]

#Data Completion

data <- complete(impute,3)
sum(is.na(data))

#Saving the Data
write.csv(data, "TBclean.csv")

#DMV
library(dplyr)
library(ggplot2)

data %>%
  filter(sm == 1) %>%
  arrange(desc(patronage))
data%>%
  group_by(female)%>%
  summarise(Avg_sm = mean(sm),
            Avg_healthy = mean(importanthealthy)) %>%
  arrange(Avg_sm)
  
#Histogram

data %>%
  filter(sm == 1) %>%
  ggplot(aes(taco_bellhealthy, fill = female)) +
  geom_histogram()+
  ggtitle("Importance of Healthy Options at Taco Bell")+
  facet_wrap(vars(female))
data$female <- as.factor(data$female)