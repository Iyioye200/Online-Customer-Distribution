---Exploring Joining Tables

SELECT
distinct SalesOrderNumber,
B.CustomerKey,A.ProductKey,A.OrderDate,A.ProductStandardCost,
A.OrderQuantity,A.SalesAmount,A.UnitPrice,A.DiscountAmount, A.TotalProductCost,c.SalesTerritoryKey,
B.BirthDate,
B.MaritalStatus,
B.Gender,B.YearlyIncome,B.TotalChildren,B.NumberChildrenAtHome,B.NumberCarsOwned,
B.EnglishEducation,B.EnglishOccupation,B.HouseOwnerFlag,B.CommuteDistance
FROM DimCustomer AS B
left JOIN dbo.FactInternetSales AS A
ON B.[CustomerKey] = A.[CustomerKey]
left join DimSalesTerritory as c
on c.SalesTerritoryKey = A.SalesTerritoryKey
order by A.OrderDate asc

-- Product Table
SELECT Q.EnglishProductCategoryName,a.EnglishProductSubcategoryName,
z.ProductKey,z.EnglishProductName
from DimProductSubcategory a
left join DimProduct z
on a.ProductSubcategoryKey = z.ProductSubcategoryKey
left join DimProductCategory Q
on a.ProductSubcategoryKey = z.ProductSubcategoryKey
order by EnglishProductCategoryName


-- Customer Demography Table
select CustomerKey,
BirthDate,
MaritalStatus,
Gender,YearlyIncome,TotalChildren,NumberChildrenAtHome,NumberCarsOwned,
EnglishEducation,EnglishOccupation,HouseOwnerFlag,CommuteDistance,DateFirstPurchase
from DimCustomer

-- Sales Table
Select ProductKey,CustomerKey,SalesTerritoryKey,
SalesOrderNumber,OrderQuantity,OrderDate,UnitPrice,ProductStandardCost,
TotalProductCost,SalesAmount
 from FactInternetSales

 select distinct SalesTerritoryKey,GeographyKey,City,EnglishCountryRegionName
 from DimGeography


 -- English city and countryregionname
 select b.SalesTerritoryKey,GeographyKey,City,EnglishCountryRegionName
  from DimGeography b
left join DimSalesTerritory a
on b.SalesTerritoryKey = a.SalesTerritoryKey
order by SalesTerritoryKey

-- distinct All Salesterritory
 select distinct SalesTerritoryKey,EnglishCountryRegionName from DimGeography
 
 -- Getting All customers and thier order dates

 Select CustomerKey,OrderDate
 from FactinternetSales
 order by CustomerKey

 --Getting the Last order dates for all customers
 select max(OrderDate)as LastOrderdate, CustomerKey  from FactInternetSales
 group by CustomerKey ;


 -- Getting the LastOrder Date
select MAX(Orderdate) from FactInternetSales;

-- calculating Days and Months difference from last purchase date to last order date

declare @d1 datetime = '2014-01-28'
select distinct CustomerKey,Max(OrderDate) as LastPurchaseDate,  
abs(Datediff(DD,@d1,max(OrderDate)))Days, 
case when @d1 >= max(OrderDate)
then convert(varchar,DATEDIFF(MONTH,max(OrderDate),@d1)) end as Months
from FactInternetSales
group by CustomerKey
Order by Months desc

select SalesOrderNumber from FactInternetSales
