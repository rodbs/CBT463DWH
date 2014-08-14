USE AdventureWorksDW2012
GO

--Star schema
select * from FactFinance
select * from DimScenario
select * from DimAccount
select * from DimOrganization
select * from DimDepartmentGroup

--Snowflake schema
select * from FactProductInventory
select * from DimProduct
select * from DimProductSubcategory
select * from DimProductCategory
select * from DimDate

--Hybrid schema
select * from FactInternetSales
select * from DimProduct
select * from DimDate
select * from DimCustomer
select * from DimSalesTerritory
select * from DimGeography
select * from DimPromotion
select * from DimCurrency



--View historical records from type 2 SCD implementation on product dimension
SELECT 
	* 
FROM 
	DimProduct
WHERE 
	ProductAlternateKey IN 
		(
		select 
			ProductAlternateKey 
		from 
			DimProduct 
		group by 
			ProductAlternateKey 
		having count(*) > 1
		)

