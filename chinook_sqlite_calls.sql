--`non_usa_customers.sql`: 
--Provide a query showing Customers (just their full names, customer ID and country) 
--who are not in the US.

SELECT c.FirstName as "First Name", c.LastName as "Last Name", c.CustomerId as "Customer ID", c.Country as "Country"
FROM Customer c 
WHERE c.Country != "USA";



--`brazil_customers.sql`: 
--Provide a query only showing the Customers from Brazil.

SELECT c.FirstName as "First Name", c.LastName as "Last Name", c.CustomerId as "Customer ID", c.Country as "Country"
From Customer c
WHERE c.Country == "Brazil";


--brazil_customers_invoices.sql`: 
--Provide a query showing the Invoices of customers who are from Brazil. 
--The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.FirstName as "First Name", c.LastName as "Last Name", i.InvoiceId as "Invoice ID", i.InvoiceDate as "Invoice Date", i.BillingCountry as "Billing Country"
From Customer c, Invoice i
WHERE c.Country == "Brazil"
AND i.CustomerID == c.CustomerID;




--`sales_agents.sql`: 
--Provide a query showing only the Employees who are Sales Agents.

SELECT  e.FirstName as "First Name", e.LastName as "Last Name" 
FROM Employee e 
WHERE e.Title == "Sales Support Agent";




--`unique_invoice_countries.sql`: 
--Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT i.BillingCountry as "Individual Billing Countries"
FROM Invoice i
GROUP BY i.BillingCountry;





--`sales_agent_invoices.sql`: 
--Provide a query that shows the invoices associated with each sales agent. 
--The resultant table should include the Sales Agent's full name.

SELECT e.FirstName || " " || e.LastName as "Agent Name", c.FirstName || " " || c.LastName as "Customer Name",  i.InvoiceID as "Invoice ID", i.InvoiceDate as "Invoice Date", i.[Total] as "Invoice Total"
From Employee e, Customer c, Invoice i
WHERE  c.SupportRepId == 3
AND e.EmployeeId == 3
AND i.CustomerId == c.CustomerId;





--`invoice_totals.sql`: 
--Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT e.FirstName as "Agent First Name", e.LastName as "Agent Last Name", c.FirstName as "Customer First Name", c.LastName as "Customer Last Name", c.Country as "Customer Country" , i.[Total] as "Invoice Total"
FROM Employee e, Customer c, Invoice i;

--`total_invoices_{year}.sql`: 
--How many Invoices were there in 2009 and 2011?

SELECT SUBSTR(i.InvoiceDate, 0, 5) as "Year", count(i.InvoiceId) as "Number Of Invoices"
FROM Invoice i
WHERE i.InvoiceDate  LIKE '2009%' 
OR i.InvoiceDate LIKE '2011%'
GROUP BY SUBSTR(i.InvoiceDate, 0, 5);


--total_sales_{year}.sql
--What are the respective total sales for each of those years?


SELECT SUBSTR(i.InvoiceDate, 0, 5) as "Year", SUM(i.[Total]) as "Total"
FROM Invoice i
WHERE i.InvoiceDate  LIKE '2009%' 
OR i.InvoiceDate LIKE '2011%'
GROUP BY SUBSTR(i.InvoiceDate, 0, 5);


--invoice_37_line_item_count.sql
-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT il.InvoiceId as "Invoice ID", COUNT(il.InvoiceLineId) as "Line Items"
FROM InvoiceLine il
WHERE il.InvoiceId == 37;

--line_items_per_invoice.sql 
--Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. 
  --HINT: GROUP BY

  SELECT il.InvoiceId as "Invoice ID" , COUNT(il.InvoiceLineId) as "Line Items"
  FROM InvoiceLine il
  GROUP BY il.InvoiceId;
  
  
  
  --line_item_track.sql
  --Provide a query that includes the purchased track name with each invoice line item.
SELECT t.Name as "Track" , il.InvoiceId as "Invoice Id", il.InvoiceLineId as "Invoice Line Item"
FROM Track t, InvoiceLine il
WHERE t.TrackId == il.TrackId;



--line_item_track_artist.sql
--Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT t.Name as "Track" , art.Name as "Artist", il.InvoiceId as "Invoice Id", il.InvoiceLineId as "Invoice Line Item"
FROM Track t, InvoiceLine il, Album al, Artist art
WHERE il.TrackId == t.TrackId
AND al.AlbumId == t.AlbumId
AND al.ArtistId == art.ArtistId;


--country_invoices.sql
-- Provide a query that shows the # of invoices per country. 
 --HINT: GROUP BY
 
 SELECT COUNT(i.InvoiceId) as "Number Of Invoices", i.BillingCountry as "Country"
 FROM Invoice i
 GROUP BY i.BillingCountry;
 
 
 

--playlists_track_count.sql
-- Provide a query that shows the total number of tracks in each playlist. 
--The Playlist name should be include on the resulant table.

SELECT p.Name as "Playlist", COUNT(pt.TrackId) as "Number Of Tracks"
FROM Playlist p, PlaylistTrack pt
WHERE p.PlaylistId == pt.PlaylistId
GROUP BY p.Name;


--tracks_no_id.sql
-- Provide a query that shows all the Tracks, but displays no IDs. 
--The result should include the Album name, Media type and Genre.

SELECT t.Name as "Track Name", al.Title as "Album Name" , mt.Name as "Media Type", g.Name as "Genre"
FROM Track t, Album al, MediaType mt, Genre g
WHERE t.AlbumID == al.AlbumId
AND t.MediaTypeId == mt.MediaTypeId
AND t.GenreId == g.GenreId;





--invoices_line_item_count.sql
-- Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT i.InvoiceID as "Invoice Id", i.CustomerId as "Customer Id", 
			i.InvoiceDate as "InvoiceDate", i.BillingAddress || " " || i.BillingCity || ", " || i.BillingState || " " || i.BillingPostalCode || " " || i.BillingCountry as "Billing Address",
			COUNT(il.InvoiceLineId) as "Number Of Line Items", i.[Total] as "Total"
FROM Invoice i, InvoiceLine il
WHERE i.InvoiceId == il.InvoiceId
GROUP BY i.InvoiceId;



--sales_agent_total_sales.sql 
-- Provide a query that shows total sales made by each sales agent.

SELECT e.FirstName || " " || e.LastName as "Sales Agent", SUM( i.Total) as "Total Sales"
FROM Employee e, Invoice i, Customer c 
WHERE i.CustomerId == c.CustomerId
AND c.SupportRepId == e.EmployeeId
AND e.Title == "Sales Support Agent"
GROUP BY e.FirstName || " " || e.LastName;


--top_2009_agent.sql
-- Which sales agent made the most in sales in 2009?

SELECT e.FirstName || " " || e.LastName as "Sales Agent", SUM( i.Total) as "Total Sales"
FROM Employee e, Invoice i, Customer c 
WHERE i.CustomerId == c.CustomerId
AND c.SupportRepId == e.EmployeeId
AND e.Title == "Sales Support Agent"
AND i.InvoiceDate LIKE "2009%"
GROUP BY e.FirstName || " " || e.LastName
order by SUM(i.Total) desc
Limit 1;


--top_agent.sql
--Which sales agent made the most in sales over all
SELECT e.FirstName || " " || e.LastName as "Sales Agent", SUM(i.Total) as "Total Sales"
FROM Employee e, Invoice i, Customer c 
WHERE i.CustomerId == c.CustomerId
AND c.SupportRepId == e.EmployeeId
AND e.Title == "Sales Support Agent"
GROUP BY e.FirstName || " " || e.LastName
order by SUM(i.Total) desc
Limit 1;


--sales_agent_customer_count.sql
-- Provide a query that shows the count of customers assigned to each sales agent.

SELECT e.FirstName || " " || e.LastName as "Sales Rep", COUNT(c.SupportRepId) as "Number of Customers"
FROM Employee e, Customer c
WHERE c.SupportRepId == e.EmployeeId
GROUP BY e.FirstName || " " || e.LastName ;

--sales_per_country.sql 
-- Provide a query that shows the total sales per country.


SELECT i.BillingCountry as "Country", SUM(i.Total) as "Sales"
FROM Invoice i 
GROUP BY i.BillingCountry;


--top_country.sql
-- Which country's customers spent the most?
SELECT i.BillingCountry as "Country", SUM(i.Total) as "Sales"
FROM Invoice i 
GROUP BY i.BillingCountry
ORDER BY SUM(i.Total) desc;




--top_2013_track.sql
-- Provide a query that shows the most purchased track of 2013.

SELECT t.Name as "Track Name", COUNT(il.TrackId) as "Number of Purchases" 
FROM Track t, InvoiceLine il, Invoice i 
WHERE il.TrackId == t.TrackId
AND il.InvoiceId == i.InvoiceId
AND i.InvoiceDate LIKE "2013%"
GROUP BY t.Name
ORDER BY COUNT(il.TrackId) desc
Limit 1;



--top_5_tracks.sql
-- Provide a query that shows the top 5 most purchased tracks over all.
SELECT t.Name as "Track Name", COUNT(il.TrackId) as "Number of Purchases" 
FROM Track t, InvoiceLine il
WHERE il.TrackId == t.TrackId
GROUP BY t.Name
ORDER BY COUNT(il.TrackId) desc
Limit 5;


--op_3_artists.sql
-- Provide a query that shows the top 3 best selling artists.
SELECT art.Name, COUNT(il.TrackId) as "Number Of Purchases"
FROM Artist art, InvoiceLine il, Track t, Album al
WHERE il.TrackId == t.TrackId
AND t.AlbumId == al.AlbumId
AND al.ArtistId == art.ArtistId
Group By art.Name
ORDER BY COUNT(il.TrackId) desc
Limit 3;


--top_media_type.sql
-- Provide a query that shows the most purchased Media Type.

SELECT mt.Name as "Media Type", COUNT(il.TrackId) as "Number of Purchases"
FROM MediaType mt, InvoiceLine il, Track t
WHERE il.TrackId == t.TrackId
AND t.MediaTypeId == mt.MediaTypeId
Group By mt.Name
Order By COUNT(il.TrackId) desc
Limit 1;