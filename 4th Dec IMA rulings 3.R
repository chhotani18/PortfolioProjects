data <- read.csv(file.choose(),header = T)
str(data)

sum(is.na(data))
library(psych)
pairs.panels(data[1:14])

#multiple regression

results <- lm(Sales ~ NationalTV1 + NationalTV2 + Magazine1 + Magazine2 + PaidSearch1 + PaidSearch2 + Display1 + Display2 + Facebook1 + Facebook2 + Whatsapp1 + Whatsapp2 + Sales.Event, data)
summary(results)

results1 <- lm(Sales ~ Whatsapp2 + Sales.Event, data)
summary (results1)

#sales = 200590 +20.1 W2 + 48977.3 SE


#simple regression for q1 on wird doc as coefficent is higher 

results2 <- lm(Sales ~ Sales.Event, data)
results2
 