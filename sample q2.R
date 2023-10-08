install.packages("DBI", dependencies = True)
install.packages("RSQLite", dependencies = True)

library(DBI)
library(RSQLite)

drv <- dbDriver('SQLite')
con <- dbConnect(drv, dbname="Northwind_small.sqlite")

dbListTables(con)

#1
#Your boss wants all the information regarding the first five orders with the freight charges. 
#Run an SQL query and share the results below.

dbGetQuery(con, "select* from `Order` limit 5")
#2
#Your boss wants the shipping company’s name and the name of the shipments that had a freight cost of $800 or
#more. Run an SQL query and share the results below.)
dbGetQuery(con, "select CompanyName, ShipName from Shipper join `Order` on ShipVia = Shipper.Id where Freight >= 800")

#3
#Your boss wants the following details of all the orders with a freight cost of $800 or more: the shipment country, the first
#and last name of the employee responsible and the name of the territory he/she belongs to. Run an SQL query and share the results
#below.

dbListFields(con, "Territory")

dbGetQuery(con, "Select ShipCountry, FirstName, LastName, TerritoryDescription 
                from `Order` join Employee on `Order`.EmployeeId = Employee.Id
                join EmployeeTerritory on Employee.Id = EmployeeTerritory.EmployeeId
                join Territory on TerritoryId = Territory.Id Where Freight>=800")

#4 
#Your boss wants the the product name, discount offered, and freight charges 
#where shipment address is Walserweg
#21. Run an SQL query and share the results below.
dbListTables(con)
dbListObjects(con, "ShipAddress")
dbGetQuery(con, "Select ProductName, Discount, Freight from Product join `OrderDetail`
           on Product.Id = ProductId join `Order` on OrderId = `Order`.Id where ShipAddress = 'Walserweg 21'")

           
           
           