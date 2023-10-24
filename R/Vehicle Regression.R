#Import Data

vehicle <- read.csv(file.choose(), header = T)
str(vehicle)

#Missing Data
sum(is.na(vehicle))

#Multiple Plots
pairs(vehicle[3:5])

#Multiple Linear Regression
results <- lm(lc ~ Mileage + lh, vehicle)
results

#lc = 1.375 + 73.55lh - 0.0000848Mileage

summary(results)


#Simple Linear Regression
finalresult <- lm(lc ~ lh, vehicle)

#lc = 73.51lh - 0.236
summary(finalresult)

#ANOVA
anova(results, finalresult)

#Prediction
#lc = 73.51lh - 0.236

predict(finalresult, data.frame(lh = 10), interval = "confidence")
