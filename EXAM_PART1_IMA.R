library(plyr)
library(mice)
library(dplyr)
library(ggplot2)
library(sqldf)
library(DBI)
library(RSQLite)
library(psych)

#Importing data
data<- read.csv(file.choose()  ,header = T)

str(data)  #Factor variable is Character variable
summary(data)    #NAs exist

#NA
sum(is.na(data))


#Converting charactor to factor
data$Camp3<-as.factor(data$Camp3)
data$Camp4<-as.factor(data$Camp4)
data$Camp5<-as.factor(data$Camp5)
data$Camp1<-as.factor(data$Camp1)
data$Camp2<-as.factor(data$Camp2)
data$Comp<-as.factor(data$Comp)
data$Response<-as.factor(data$Response)

str(data)

unique(data$Education)
unique(data$Rstatus)

table(data$Education)
table(data$Rstatus)

data$Education<-as.factor(data$Education)
data$Rstatus<- revalue(data$Rstatus, c("Alone"= "Single"))
unique(data$Rstatus)
data$Rstatus<-as.factor(data$Rstatus)

str(data)
#Imputing missing values
impute<- mice(data,m=3,seed=123)
print(impute)
data<- complete(impute,2)
sum(is.na(data))
str(data)
summary(data)
##############################################################

# Response of people who recently bought

Q1<- sqldf("SELECT LP,Response
           FROM data
           ORDER BY LP")
pairs.panels(data[c(18,25)], cex.cor = 0.5)


data[16,c(18,25)]
data[15,c(18,25)]


Q2<- sqldf("SELECT SUM(DrinkAM+ChickenAM+FruitsAM+BeefAM+DessertAM) AS Totalspend, Education, Rstatus, TeenH, NoC, Inc
           FROM data
           WHERE Response=1
           ORDER BY Totalspend DESC")



Q3<- sqldf("SELECT MAX(DrinkAM), MAX(ChickenAM), MAX(FruitsAM), MAX(BeefAM), MAX(DessertAM), Education, Rstatus, TeenH, NoC, Inc
           FROM data
           WHERE Response=1")
