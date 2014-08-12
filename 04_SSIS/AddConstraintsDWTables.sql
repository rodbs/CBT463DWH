ALTER TABLE DimProductSubcategory
	WITH CHECK ADD CONSTRAINT FK_DimProductSubcategory_DimProductCategory
	FOREIGN KEY(ProductCategoryKey) REFERENCES DimProductCategory(ProductCategoryKey)
GO

ALTER TABLE DimProduct
	WITH CHECK ADD CONSTRAINT FK_DimProduct_DimProductSubcategory
	FOREIGN KEY(ProductSubcategoryKey) REFERENCES DimProductSubcategory(ProductSubcategoryKey)
GO

ALTER TABLE FactInternetSales 
	WITH CHECK ADD CONSTRAINT FK_FactInternetSales_DimProduct
	FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)
GO

ALTER TABLE FactProductInventory
	WITH CHECK ADD CONSTRAINT FK_FactProductInventory_DimProduct
	FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)
GO

ALTER TABLE FactResellerSales
	WITH CHECK ADD CONSTRAINT FK_FactResellerSales_DimProduct
	FOREIGN KEY(ProductKey) REFERENCES DimProduct(ProductKey)
GO