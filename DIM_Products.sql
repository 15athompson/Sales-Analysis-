--Cleansed DIM_Products Table--
SELECT 
  p.ProductKey AS ProductKey, 
  p.ProductAlternateKey AS ProductItemCode, 
  p.EnglishProductName AS ProductName, 
--joined in from product subcategory table--
  ps.EnglishProductSubcategoryName AS SubCategory, 
--joined in from product category table
  pc.EnglishProductCategoryName AS CategoryName, 
  p.Color AS ProductColor, 
  Size AS ProductSize, 
  p.ProductLine, 
  p.ModelName AS ProductModelName, 
  p.EnglishDescription AS ProductDescription, 
--the NULLs are changed to outdated as the status cannot be verified--
  ISNULL (p.Status, 'Outdated') AS ProductStatus 
FROM 
  dbo.DimProduct AS p 
--two joins are added to provide more information of products --
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON pc.ProductCategoryKey = ps.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC;