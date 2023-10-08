#waniya will take parsehub class for sssignmennt
# ML course
#consecutive sunday classes. Deep learning might not be completed

#thematic vs tactical. thematic jismay aap theme establish kartay hain. Dostea wala thematic was first. 

#Shan was bhai wali ad on eid. Emotional appeal. COnnect build kartay. 6-8 week mai aap tactical nikaltay hain. Can be atl, btl jismai aap activations aur gondolas waghera kartay hain. Tatcial is to push it  

#Clustering analysis

#imported the data using the import dataset on right
str(utilities)
pairs(utilities[2:9]) #just to see realtionship very quickly. Sales is main variable as that is the main variable for any business. So see ke baaki sab ki relationship between sales and all other variables

plot(utilities$Fuel_Cost ~ utilities$Sales) #this will show me. some form of clusters are forming. 3 clusters can be made. 3 set of companies could be made from the scatter plot based on fuel cost and sales. Jo right bottom walay hain wo shayad itnay benefitial hon ke i want to focus specialized on them. left top walay are very costly so perhaps focus less on them
#strategic business unit can be a prpduct, vertical a group of products or whatever. mainay abhi ye decision nahi liya konsay clusters karoon ga. but ye decision le liya ke 3 clusters hongay

#data cleaning. koi missing value tou nahi hai
sum(is.na(utilities)) #no missing values after i ran this
final <- utilities[,2:9]# i wanto to remove compnaies
final1 <- utilities #running before final1$companies so that final1 is defined as the utilities data
final1$Company <- NULL #another way of doing same. removing company
final2 <- utilities[, -c(1,2,6)] # another way of removing. I want to remove column 1,2,6


#normalizing data
#sales data is in 1000s while others are not. so im noralizing it taake aik scale par ajai sab

means= apply(final, 2, mean)
sds= apply (final,2, sd)

nor = scale(final, center = means, scale=sds) #ASK MISS

#elbow method. You do this to find out the number of clusters. You use sum of squares for this. IT will tell you variance kitna hai. You use sum of squares where jahaan turning point aata hai (this is the point where you choose  the number of clusters) uske baad data same hona shuru hojata hai
wss <- (nrow(nor)-1)*sum(apply(nor,2,var)) #within sum of squares. number of rows from dataset nor. -1 column. usko  #ASK MISS 
for(i in 2:20) wss[i] <- sum (kmeans(nor,centers=i)$withinss) #for loop is aap jo wss nikaal rahay hain ki cheez ke liye nikal rahay hain. running a loop for i for 2:20 means iterating for this. We will assign more values from 2 till 20 clusters. Then you are running a k means clusters on the bases of number of centeroids you want. When we run K means withinss run hota hai.   
plot(1:22, wss, type = "b", xlab = "Number of CLusters", ylab = "within groups sum of squares") #plot 1-20. Mainay oopar 2-20 likha tha tou yahaan 1-20 bana do. ASK MISS

# PRACTICE
set.seed(123)
finalclusters <- kmeans(final, 3)

#elbow method
kmax <- 10
wss <- rep(NA,kmax) #run repetivietly on NA's till 10
nclust <- list()

for(i in 1:kmax) {
  finalClasses <- kmeans(final,i) 
  wss[i] <- finalClasses$tot.withinss #pehlay mainay wss calculate kiya tha but this time i picked up. 
  nclust[[i]] <- finalClasses $size
}

plot(1:10, wss, type = "b", xlab = "Number of CLusters", ylab = "within groups sum of squares")
# END PRACTICE


#k means clustering. note: sum of squares is variance
set.seed(123) #to fix randomness

kc3 <- kmeans(nor,3) #after segemntation you target
set.seed(123)
kc4<-kmeans (nor,4)

#plotting the results
install.packages('cluster')
library(cluster) #jitnay ziada clusters utnay ziada acha

clusplot(utilities,kc4$cluster,
         color = T,
         shade = T,
         labels =2,
         lines = 0)


