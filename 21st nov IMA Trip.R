tripdetails <- read.csv(file.choose(),header = T)

str(tripdetails)
#datacleaning

sum(is.na(tripdetails))

tripfinal <- tripdetails
tripfinal$TripID <- NULL

#clustering. we will not target more than 3 

set.seed(123)
tripclusters <- kmeans(tripfinal, 3)

#elbow method
kmax <- 10
wss <- rep(NA,k.max) #run repetivietly on NA's till 10
nclust <- list()


for(i in 1:kmax) {
  tripClasses <- kmeans(tripfinal,i) 
  wss[i] <- tripClasses$tot.withinss #pehlay mainay wss calculate kiya tha but this time i picked up. 
  nclut[[i]] <- tripClasses $size
}


plot(1:18, wss, type = "b", xlab = "Number of CLusters", ylab = "within groups sum of squares")

?kmeans #to know your the definition. Or go to help and search kmeans and youll get all definitions

