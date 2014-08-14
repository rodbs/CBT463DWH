USE AdventureWorksDW2012
GO


--Add a new filegroup for each year
ALTER DATABASE AdventureWorksDW2012 ADD FILEGROUP FactProdInv2005
GO
ALTER DATABASE AdventureWorksDW2012 ADD FILEGROUP FactProdInv2006
GO
ALTER DATABASE AdventureWorksDW2012 ADD FILEGROUP FactProdInv2007
GO
ALTER DATABASE AdventureWorksDW2012 ADD FILEGROUP FactProdInv2008
GO
ALTER DATABASE AdventureWorksDW2012 ADD FILEGROUP FactProdInvCurrent
GO

--Add a data file per filegroup for each year
ALTER DATABASE AdventureWorksDW2012 
ADD FILE 
(
    NAME = FactProdInv2005,
    FILENAME = 'C:\70-463 Support Files\FactProductInventory2005.ndf',
    SIZE = 250MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 100MB
)
TO FILEGROUP FactProdInv2005
GO

ALTER DATABASE AdventureWorksDW2012 
ADD FILE 
(
    NAME = FactProdInv2006,
    FILENAME = 'C:\70-463 Support Files\FactProductInventory2006.ndf',
    SIZE = 250MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 100MB
)
TO FILEGROUP FactProdInv2006
GO

ALTER DATABASE AdventureWorksDW2012
ADD FILE 
(
    NAME = FactProdInv2007,
    FILENAME = 'C:\70-463 Support Files\FactProductInventory2007.ndf',
    SIZE = 250MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 100MB
)
TO FILEGROUP FactProdInv2007
GO

ALTER DATABASE AdventureWorksDW2012 
ADD FILE 
(
    NAME = FactProdInv2008,
    FILENAME = 'C:\70-463 Support Files\FactProductInventory2008.ndf',
    SIZE = 250MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 100MB
)
TO FILEGROUP FactProdInv2008
GO

ALTER DATABASE AdventureWorksDW2012 
ADD FILE 
(
    NAME = FactProdInvCurrent,
    FILENAME = 'C:\70-463 Support Files\FactProductInventoryCurrent.ndf',
    SIZE = 250MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 100MB
)
TO FILEGROUP FactProdInvCurrent
GO

--Create partition function defining year partitions
CREATE PARTITION FUNCTION pfProdInvDateKey(int) AS RANGE LEFT 
FOR VALUES 
(
	'20051231',
	'20061231',
	'20071231',
	'20081231'  
)


--Create partition scheme that maps to partition function and filegroups
CREATE PARTITION SCHEME psProdInvDateKey
AS PARTITION pfProdInvDateKey TO 
(
	FactProdInv2005,
	FactProdInv2006,
	FactProdInv2007,
	FactProdInv2008,
	FactProdInvCurrent
) 
GO


--Create a partitioned version of the FactProductInventory table
CREATE TABLE [dbo].[FactProductInventory_Partitioned](
	[ProductKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[MovementDate] [date] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[UnitsIn] [int] NOT NULL,
	[UnitsOut] [int] NOT NULL,
	[UnitsBalance] [int] NOT NULL,
) ON [psProdInvDateKey](DateKey)
GO


--Load paritioned table with data from original table
INSERT FactProductInventory_Partitioned
	SELECT * FROM FactProductInventory
GO


--View data per parition
SELECT 
	$PARTITION.pfProdInvDateKey(DateKey) as PartitionID,
    COUNT(*) as NumRecords
FROM 
	[FactProductInventory_Partitioned]
GROUP BY 
	$PARTITION.pfProdInvDateKey(DateKey)
ORDER BY
	PartitionID
GO