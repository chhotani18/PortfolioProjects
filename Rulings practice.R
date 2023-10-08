rulings <- read.csv(file.choose() , header = T)
str(rulings)


#Effect of micro influencers on sales compared to others

#Creating Dichotomous Variables
rulings$Mega <- (rulings$Influencer == 'Mega')
rulings$Macro <- (rulings$Influencer == 'Macro')
rulings$Micro <- (rulings$Influencer == 'Micro')
rulings$Nano <- (rulings$Influencer == 'Nano')

results <- lm(Sales ~ Mega + Macro + Micro + Nano, rulings)
summary(results)

results1 <- lm(Sales ~ Micro, rulings)
summary(results1)

#Avg impact of 1st NTV on 1st Magazine

resultsMGTV <- lm(Sales ~ Magazine1 + NationalTV1 + (Magazine1*NationalTV1), rulings)
summary(resultsMGTV)

rulings$cNationalTV1 <- (rulings$NationalTV1 - mean(rulings$NationalTV1))

resultsCENmgtv <- lm(Sales ~ Magazine1 + cNationalTV1 + (Magazine1*cNationalTV1), rulings)
summary(resultsCENmgtv)

#When NationalTV1 exp are average, for every $1 increase in Magazine1 ad exp, sales will increase by $5874.3

#Impact of Micro influencers on sales from Facebook video ads

resultsFBmicro <- lm(Sales ~ Facebook1 + Micro + (Facebook1*Micro) , rulings)
summary(resultsFBmicro)

#no signifigant interaction, don't hire

#creating non-micro variable #if interaction had been signifigant

rulings$nonmicro <- (rulings$Micro == FALSE)

resultsFBnm<- lm(Sales ~ Facebook1 + nonmicro + (Facebook1*nonmicro), rulings)
summary(resultsFBnm)

#High impact of 1st NTV on 2nd NTV

resultsNTV <- lm(Sales ~ NationalTV2 + NationalTV1 + (NationalTV2*NationalTV1), rulings)
summary(resultsNTV)

#avg
rulings$cNTV <- (rulings$NationalTV1 - mean(rulings$NationalTV1))

resultsCENNTV <- lm(Sales ~ NationalTV2 + cNTV + (NationalTV2*cNTV), rulings)
summary(resultsCENNTV)

#high
rulings$cNTVHigh <- (rulings$cNTV - sd(rulings$cNTV)) #subtracting 1 sd from cFacebook, 0 moved up

resultsHigh <- lm(Sales ~ NationalTV2 + cNTVHigh + (NationalTV2*cNTVHigh), rulings)
summary(resultsHigh)

#results are marginally significant 