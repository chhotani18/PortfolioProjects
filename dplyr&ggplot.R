install.packages("dplyr")
install.packages("ggplot2")

library(dplyr)
library(ggplot2)

#Data
vehicle <- read.csv(file.choose(), header = T)
str(vehicle)

car <- as_tibble(vehicle)
tibble
str(car) 

#Using the filter function

car %>% 
  filter(State == "CA" | State == "FL" | State == "TX")
car %>%
  filter(State == "FL", Mileage > 1000)

#Using the arrange function

car%>%
  filter(State == "CA" | State == "FL" | State == "TX")%>%
  arrange(desc(Mileage))

#Summarise Function

car %>%
  summarise(Avg_lc = mean(lc),
            sd_lc = sd(lc),
            max_lc = max(lc),
            min_lc = min(lc),
            total = n())

#Group by Function

car%>%
  group_by(State) %>%
  summarise(Avg_lc = mean(lc),
            sd_lc = sd(lc),
            max_lc = max(lc),
            min_lc = min(lc),
            total = n()) %>%
  arrange(Avg_lc)

#Mutate Function

car%>%
  group_by(State) %>%
  mutate(CPH) = sum((lc) / sum(lh)) %>%
  summarise(Avg_CPH = mean (CPH),
            Avg_mileage = mean(Mileage)) %>%
  arrange(desc(Avg_CPH))

#Data Visualization
Library(ggplot())

#Histogram

car%>%
  filter(State == "CA" | State == "FL" | State == "TX")%>%
  ggplot(aes(lh, fill = State))+
  geom_histogram(color = 'black')+
  ggtitle("Labour Hours in the Top 3 States")+
  facet_wrap(vars(State))

#Scatterplot

car%>%
  filter(State == "CA" | State == "FL" | State == "TX")%>%
  ggplot(aes(lh, lc, col = State, size = lc))+
  geom_point() +
  geom_smooth(se = 0) +
  ggtitle("Labour Hours vs. Costs in the Top 3 States")+
  facet_wrap(vars(State))

#Barplot
barplot_data <- car %>%
  group_by(State) %>%
  mutate(CPH = sum (lc) / sum (lh)) %>%
  summarise(Avg_CPH = mean (CPH),
            Avg_mileage = mean(Mileage)) %>%
  arrange(desc(Avg_CPH))
ggplot(barplot_data, aes(Avg_CPH, State, fill = State))+
  geom_col()+
  coord_flip()+
  ggtitle("Barplot for Average CPH for all States")
