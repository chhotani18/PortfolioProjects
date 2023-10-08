library(DBI)
library(RSQLite)
library(sqldf)

drv <- dbDriver('SQLite')
con <- dbConnect(drv, dbname = "chinook.db")
dbListTables(con)
#1
A <- dbGetQuery(con, "SELECT* FROM Track ORDER BY Milliseconds")
#2
b <- dbGetQuery(con, SELECT)



#5
c <- dbGetQuery(con, "Select Artist.Name, Title, Sum(Milliseconds)/1000 AS Length FROM Album JOIN Artist USING (ArtistId) JOIN Track USING (AlbumId) Group by (AlbumId) HAVING Length >1000 ORDER BY Length DESC")

#Displaycustomer last name, first name, track name, unit price 
#and the quantity for all track purchases
toughq <- dbGetQuery(con,"select customer.lastname, customer.firstname, Track.Name, Track.UnitPrice, SUM(InvoiceLine.Quantity)
                     FROM Customer JOIN Invoice USING (CustomerId) join InvoiceLine using (InvoiceId) join Track USING (TrackId) Group by customer.customerid")
dbDisconnect(con)
