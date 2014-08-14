
USE AdventureWorks2012
GO


--Enable CDC for current database
EXEC sys.sp_cdc_enable_db
GO

--Enable table for CDC
EXEC sys.sp_cdc_enable_table 
	@source_schema = 'Sales', 
	@source_name   = 'SalesOrderHeader', 
	@role_name     = NULL 
GO

--View database CDC information
EXEC sys.sp_cdc_help_change_data_capture
GO

--Disable CDC for table
EXEC sys.sp_cdc_disable_table
    @source_schema	= 'Sales',
    @source_name	= 'SalesOrderHeader',
	@capture_instance = 'Sales_SalesOrderHeader'
GO


--CDC staging table
CREATE TABLE [dbo].[FactInternetSales_cdcstaging](
	[SalesOrderID] [int] NOT NULL,
	[$operation] [int] NULL
) ON [PRIMARY]

GO

select * from FactInternetSales_cdcstaging