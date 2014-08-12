IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_DimProductSubcategory_DimProductCategory', 'F'))
	ALTER TABLE DimProductSubcategory DROP CONSTRAINT FK_DimProductSubcategory_DimProductCategory
GO

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_DimProduct_DimProductSubcategory', 'F'))
	ALTER TABLE DimProduct DROP CONSTRAINT FK_DimProduct_DimProductSubcategory
GO

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_FactInternetSales_DimProduct', 'F'))
	ALTER TABLE FactInternetSales DROP CONSTRAINT FK_FactInternetSales_DimProduct
GO

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_FactProductInventory_DimProduct', 'F'))
	ALTER TABLE FactProductInventory DROP CONSTRAINT FK_FactProductInventory_DimProduct
GO

IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_FactResellerSales_DimProduct', 'F'))
	ALTER TABLE FactResellerSales DROP CONSTRAINT FK_FactResellerSales_DimProduct
GO


TRUNCATE TABLE DimProductSubcategory
GO

TRUNCATE TABLE DimProductCategory
GO

TRUNCATE TABLE DimProduct
GO