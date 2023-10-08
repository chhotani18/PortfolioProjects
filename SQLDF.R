#install.packages("DBI", dependencies = TRUE)
#install.packages("RSQLite", dependencies = TRUE)
#install.packages("sqldf", dependencies = TRUE)

library(sqldf)

#Import employees and orders data

employees <- read.csv(file.choose(), header = T)
orders <- read.csv(file.choose(), header = T)

male_employees <- sqldf("select* from employees where gender = 'm'")

sqldf("select firstname, COUNT(firstname) AS count
      from employees where firstname <> 'rudi' group by firstname")

#unlogon ka item aur firstname aur quantity jinki quantity 1 ho 

motencase <- sqldf("select firstname, lastname, item, sum(quantity_ordered) AS total from employees join orders on employees.id = orders.id where quantity_ordered = 1 group by lastname")