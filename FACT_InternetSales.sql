--Cleansed from FACT_InternationalSales Table--
SELECT 
  ProductKey, 
  OrderDateKey, 
  DueDateKey, 
  ShipDateKey, 
  CustomerKey, 
  SalesOrderNumber, 
  SalesAmount 
FROM 
  dbo.FactInternetSales 
--This is used to ensure it only brings the last 2 years of data(will do it automatically for the future)--
--Left is used to only get the year value from the date key--
WHERE 
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) -2 
ORDER BY 
  OrderDateKey ASC;