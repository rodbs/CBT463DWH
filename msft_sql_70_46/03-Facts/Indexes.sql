USE AdventureWorksDW2012
GO


--Add Clustered index on surrage key column
ALTER TABLE dbo.FactSalesQuota
	ADD CONSTRAINT PK_FactSalesQuota_SalesQuotaKey PRIMARY KEY CLUSTERED(SalesQuotaKey ASC)
GO


--Add Non-Clustered index on foreign key columns
CREATE NONCLUSTERED INDEX IX_FactSalesQuota_DateKey 
	ON dbo.FactSalesQuota(DateKey)
GO

CREATE NONCLUSTERED INDEX IX_FactSalesQuota_EmployeeKey 
	ON dbo.FactSalesQuota(EmployeeKey)
GO


--Add Columnstore index to dramatically speed up large fact tables
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_CS_FactProductInventory 
	ON dbo.FactProductInventory(ProductKey, DateKey, UnitCost, UnitsIn, UnitsOut, UnitsBalance)
GO


SET STATISTICS TIME ON
SET STATISTICS IO ON
GO

--Query to improve via Columnstore index
SELECT 
	EnglishProductName, 
	CalendarYear,
	SUM(UnitsIn) as TotalUnitsIn, 
	SUM(UnitsOut) as TotalUnitsOut
FROM 
	dbo.FactProductInventory fpi
		JOIN 
	dbo.DimProduct dp ON fpi.ProductKey = dp.ProductKey
		JOIN 
	dbo.DimDate dd ON fpi.DateKey = dd.DateKey
GROUP BY 
	EnglishProductName, CalendarYear
ORDER BY 
	EnglishProductName, CalendarYear
GO

SET STATISTICS TIME OFF
SET STATISTICS IO ON
GO


