data <- read.csv(file.choose(), header = T)
summary(data)

library(dplyr)
library(sqldf)
library(ggplot2)

BudgetGPUs <- data %>%
  filter(GPU_Dsc_Price < 30000)

currentGPUprices <- data %>%
  summarize(Avg_Price = mean(data$GPU_Dsc_Price),
            sd_Price = sd(data$GPU_Dsc_Price),
            max_Price = max(data$GPU_Dsc_Price),
            min_Price = min(data$GPU_Dsc_Price),
            total = n())

Discounted_Cards <- data %>%
  filter(data$GPU_Discount > 0)

BestDeal <- data %>%
  filter(data$GPU_Discount > 0.5)
  

BestDealNvidia <- Nvidia_Cards%>%
  arrange(desc(data$GPU_Discount)) %>%
  filter(data$GPU_Discount < 0.50)

Nvidia_Cards <- data %>%
  filter(grepl('Nvidia|nvidia|GeForce|GT|GTX|RTX|Quadro', GPU_name))

AMD_Cards <- data %>%
  filter(grepl('AMD|Amd|Radeon|Rx|Firepro|FirePro', GPU_name))

