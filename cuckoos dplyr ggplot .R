install.packages ("DAAG")

library(DAAG)
library(dplyr)
library(ggplot2)

library(help = "DAAG")

#Data
data("cuckoos")
str(cuckoos)
summary(cuckoos)

#Select
cuckoos %>% select(1:2,4)

#Filter
cuckoos %>%
  filter(species == 'robin', breadth == 16:17)

#Arrange
cuckoos %>%
  filter(species == 'robin', breadth == 16:17) %>%
  arrange(desc(length))

#Summarise
cuckoos %>%
  group_by(species) %>%
  summarise(Avg_length = mean(length),
            Avg_breadth = mean (breadth),
            total_observations = n()) %>%
  arrange(Avg_length)

cuckoos %>%
 group_by(species) %>%
  mutate(ratio = sum(length)/ sum(breadth)) %>%
  summarise(avg_ratio = mean(ratio),
            count = n())


#Histogram
cuckoos %>%
  ggplot(aes(length, fill = species)) +
  geom_histogram()+
  ggtitle("Histogram for Lengths of Various Cuckoos")+
  facet_grid(vars(species), vars(breadth))

#Scatter Plot
cuckoos %>%
  ggplot(aes(length, breadth))+
  geom_point(color = 'blue')+
  geom_smooth(se= 0, method = "lm")
