USE AdventureWorksDW2012
GO


--Add lineage columns to fact table
ALTER TABLE dbo.FactInternetSales
	ADD [SourceSystem] [nvarchar](255) NULL,
		[SourceVersion] [nvarchar](25) NULL,
		[SourceFile] [nvarchar](255) NULL,
		[ExecDateTime] [datetime] NULL
GO


--Create centralized lineage dimension
CREATE TABLE dbo.DimLineage
(
	[LineageKey] [int] IDENTITY(1,1) NOT NULL,
	[SourceSystem] [nvarchar](255) NOT NULL,
	[SourceVersion] [nvarchar](25) NOT NULL,
	[SourceFile] [nvarchar](255) NULL,
	[ExecDateTime] [datetime] NOT NULL
 CONSTRAINT [PK_DimLineage] PRIMARY KEY CLUSTERED ([LineageKey] ASC)
 )
ON [PRIMARY]
GO