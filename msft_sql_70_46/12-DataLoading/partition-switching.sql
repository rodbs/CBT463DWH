USE [master]
GO

--Add secondary data files to hold partitioned data
ALTER DATABASE AdventureWorksDW2012
	ADD FILE
		(NAME = N'factinternetdata_2005',
		FILENAME = N'C:\70-463 Support Files\12-DataLoading\data\factinternetdata_2005.ndf',
		SIZE = 100MB,
		MAXSIZE = 500MB,
		FILEGROWTH = 200MB)
	TO FILEGROUP [PRIMARY]  
GO  

ALTER DATABASE AdventureWorksDW2012
	ADD FILE
		(NAME = N'factinternetdata_2006',
		FILENAME = N'C:\70-463 Support Files\12-DataLoading\data\factinternetdata_2006.ndf',
		SIZE = 100MB,
		MAXSIZE = 500MB,
		FILEGROWTH = 200MB)
	TO FILEGROUP [PRIMARY]  
GO  

ALTER DATABASE AdventureWorksDW2012
	ADD FILE
		(NAME = N'factinternetdata_2007',
		FILENAME = N'C:\70-463 Support Files\12-DataLoading\data\factinternetdata_2007.ndf',
		SIZE = 100MB,
		MAXSIZE = 500MB,
		FILEGROWTH = 200MB)
	TO FILEGROUP [PRIMARY]  
GO  

ALTER DATABASE AdventureWorksDW2012
	ADD FILE
		(NAME = N'factinternetdata_2008',
		FILENAME = N'C:\70-463 Support Files\12-DataLoading\data\factinternetdata_2008.ndf',
		SIZE = 100MB,
		MAXSIZE = 500MB,
		FILEGROWTH = 200MB)
	TO FILEGROUP [PRIMARY]
GO


USE [AdventureWorksDW2012]
GO

--Create partition function
CREATE PARTITION FUNCTION [pf_FactInternetSalesByYear](int) AS RANGE LEFT
	FOR VALUES ('20051231', '20061231', '20071231', '20081231')
GO

--Create partition scheme tied to partition function
CREATE PARTITION SCHEME [ps_FactInternetSalesByYear] AS PARTITION [pf_FactInternetSalesByYear]
	ALL TO ([PRIMARY])
GO


--Drop current fact table (need to re-create it on partition scheme)
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimSalesTerritory]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimPromotion]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate2]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate1]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimDate]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimCustomer]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSales_DimCurrency]
GO
ALTER TABLE [dbo].[FactInternetSales] DROP CONSTRAINT [FK_FactInternetSalesReason_FactInternetSales]
GO
DROP TABLE [dbo].[FactInternetSales]
GO


--Create production table on partition scheme
CREATE TABLE [dbo].[FactInternetSales](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [nvarchar](25) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[ExtendedAmount] [money] NOT NULL,
	[UnitPriceDiscountPct] [float] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[ProductStandardCost] [money] NOT NULL,
	[TotalProductCost] [money] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[CustomerPONumber] [nvarchar](25) NULL,
	[OrderDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ShipDate] [datetime] NULL
) ON [ps_FactInternetSalesByYear](OrderDateKey)
GO

--Create staging table on partition scheme
CREATE TABLE [dbo].[FactInternetSales_staging](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [nvarchar](25) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[ExtendedAmount] [money] NOT NULL,
	[UnitPriceDiscountPct] [float] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[ProductStandardCost] [money] NOT NULL,
	[TotalProductCost] [money] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[CustomerPONumber] [nvarchar](25) NULL,
	[OrderDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ShipDate] [datetime] NULL
) ON [ps_FactInternetSalesByYear](OrderDateKey)
GO


--Switch in partition 4 (2008 data) from staging to production
ALTER TABLE [dbo].[FactInternetSales_staging]
	SWITCH PARTITION 4 TO [dbo].[FactInternetSales] PARTITION 4
GO


SELECT * FROM FactInternetSales
SELECT * FROM FactInternetSales_staging
GO