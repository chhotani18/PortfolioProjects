#Import Data
str(Redbull)

#Multiple Plot
library(psych)
pairs.panels(Redbull[1:8])

#Multiple Regression
results <- lm(sales ~ twitter + banner + facebook + instagram + youtube + tv + 
                ezine, Redbull)
results


#sales = -0.086twitter + 37.5banner + 72.75facebook + 73.41instagram + 2.66Youtube -12.10tv  +21.14 ezine

summary(results)

results1 <- lm(sales ~ banner + facebook + instagram + 
                 ezine, Redbull)

results1
#sales = 37316.868 + 67.601Facebook and so on

summary(results1)