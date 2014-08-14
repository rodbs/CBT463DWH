
--Query to shape DimProductCategory table
SELECT 
	pc.ProductCategoryID AS ProductCategoryAlternateKey, 
	pc.[Name] AS EnglishProductCategoryName, 
	tpc.SpanishProductCategoryName AS SpanishProductCategoryName, 
	tpc.FrenchProductCategoryName AS FrenchProductCategoryName 
FROM 
	Production.ProductCategory pc 
		INNER JOIN 
	temp_ProductCategoryNames tpc ON pc.[Name] = tpc.EnglishProductCategoryName




--Query to shape DimProductSubcategory table
SELECT 
	ps.ProductSubcategoryID AS ProductSubcategoryKey,    
	ps.ProductSubcategoryID AS ProductSubcategoryAlternateKey, 
	ps.[Name] AS EnglishProductSubcategoryName, 
	tps.SpanishProductSubcategoryName AS SpanishProductSubcategoryName,
	tps.FrenchProductSubcategoryName AS FrenchProductSubcategoryName,
	dpc.ProductCategoryKey AS ProductCategoryKey 
FROM 
	Production.ProductSubcategory ps 
		JOIN 
	AdventureWorksDW2012.dbo.DimProductCategory dpc ON ps.ProductCategoryID = dpc.ProductCategoryAlternateKey
		LEFT OUTER JOIN 
	temp_ProductSubcategoryNames tps ON ps.[Name] = tps.EnglishProductSubcategoryName



--Query to shape DimProduct table
SELECT 
    p.ProductNumber AS ProductAlternateKey, 
    p.ProductSubcategoryID AS ProductSubcategoryKey, 
    p.WeightUnitMeasureCode AS WeightUnitMeasureCode, 
    p.SizeUnitMeasureCode AS SizeUnitMeasureCode, 
    p.[Name] AS EnglishProductName, 
    tp.SpanishProductName AS SpanishProductName, 
    tp.FrenchProductName AS FrenchProductName, 
    pch.StandardCost AS StandardCost, 
    p.FinishedGoodsFlag AS FinishedGoodsFlag, 
    COALESCE(p.Color, 'NA') AS Color, 
    p.SafetyStockLevel AS SafetyStockLevel, 
    p.ReorderPoint AS ReorderPoint, 
    plph.ListPrice AS ListPrice, 
    p.Size AS Size, 
    CASE 
        WHEN p.Size IN ('38', '40') THEN N'38-40 CM'
        WHEN p.Size IN ('42', '44', '46') THEN N'42-46 CM'
        WHEN p.Size IN ('48', '50', '52') THEN N'48-52 CM'
        WHEN p.Size IN ('54', '56', '58') THEN N'54-58 CM'
        WHEN p.Size IN ('60', '62') THEN N'60-62 CM'
        WHEN p.Size IN ('70') THEN N'70'
        WHEN p.Size = 'L' THEN N'L'
        WHEN p.Size = 'M' THEN N'M'
        WHEN p.Size = 'S' THEN N'S'
        WHEN p.Size = 'XL' THEN N'XL'
        WHEN p.Size IS NULL THEN N'NA'
    END AS SizeRange, 
    CONVERT(float, p.Weight) AS Weight, 
    p.DaysToManufacture AS DaysToManufacture, 
    p.ProductLine AS ProductLine, 
    0.60 * plph.ListPrice AS DealerPrice, --Column was removed from OLTP - Dealer price is calculated 60% of ListPrice
    p.Class AS Class, 
    p.Style AS Style, 
    pm.[Name] AS ModelName, --DimProduct.ModelName updated from ProductModel.[Name] through Product.ProductModelID = ProductModel.ProductModelID
    pp.LargePhoto AS LargePhoto, --Get the TOP 1 LargePhoto from ProductPhoto through ProductID
    (SELECT pd.Description 
	 FROM Production.ProductModelProductDescriptionCulture pmpdc 
     INNER JOIN Production.ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
	 WHERE pmpdc.CultureID = 'en' AND pmpdc.ProductModelID = p.ProductModelID) AS EnglishDescription, --Join on ProductModelProductDescriptionCulture.
    (SELECT pd.Description 
	 FROM Production.ProductModelProductDescriptionCulture pmpdc 
     INNER JOIN .Production.ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
     WHERE pmpdc.CultureID = 'fr' AND pmpdc.ProductModelID = p.ProductModelID) AS FrenchDescription, --Join on ProductModelProductDescriptionCulture.
    (SELECT pd.Description 
	 FROM Production.ProductModelProductDescriptionCulture pmpdc 
     INNER JOIN Production.ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
     WHERE pmpdc.CultureID = 'zh-cht' AND pmpdc.ProductModelID = p.ProductModelID) AS ChineseDescription, --Join on ProductModelProductDescriptionCulture.
    (SELECT pd.Description 
	 FROM Production.ProductModelProductDescriptionCulture pmpdc 
     INNER JOIN Production.ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
     WHERE pmpdc.CultureID = 'ar' AND pmpdc.ProductModelID = p.ProductModelID) AS ArabicDescription, --Join on ProductModelProductDescriptionCulture.
    (SELECT pd.Description 
	 FROM Production.ProductModelProductDescriptionCulture pmpdc 
     INNER JOIN Production.ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
     WHERE pmpdc.CultureID = 'he' AND pmpdc.ProductModelID = p.ProductModelID) AS HebrewDescription, --Join on ProductModelProductDescriptionCulture.
    (SELECT pd.Description 
	 FROM Production.ProductModelProductDescriptionCulture pmpdc 
     INNER JOIN Production.ProductDescription pd ON pmpdc.ProductDescriptionID = pd.ProductDescriptionID 
     WHERE pmpdc.CultureID = 'th' AND pmpdc.ProductModelID = p.ProductModelID) AS ThaiDescription, --Join on ProductModelProductDescriptionCulture.
    COALESCE(plph.StartDate, pch.StartDate, p.SellStartDate) AS StartDate,
    COALESCE(plph.EndDate, pch.EndDate, p.SellEndDate) AS EndDate, 
    CASE 
        WHEN COALESCE(plph.EndDate, pch.EndDate, p.SellEndDate) IS NULL THEN N'Current'
        ELSE NULL
    END AS Status
FROM 
	Production.Product p 
		LEFT OUTER JOIN 
	Production.ProductModel pm ON p.ProductModelID = pm.ProductModelID 
		INNER JOIN 
	Production.ProductProductPhoto ppp ON p.ProductID = ppp.ProductID 
		INNER JOIN 
	Production.ProductPhoto pp ON ppp.ProductPhotoID = pp.ProductPhotoID 
		LEFT OUTER JOIN 
	Production.ProductCostHistory pch ON p.ProductID = pch.ProductID
		LEFT OUTER JOIN 
	Production.ProductListPriceHistory plph ON p.ProductID = plph.ProductID AND pch.StartDate = plph.StartDate AND COALESCE(pch.EndDate, '12-31-2020') = COALESCE(plph.EndDate, '12-31-2020') 
		LEFT OUTER JOIN 
	[temp_ProductNames] tp ON p.[Name] = tp.EnglishProductName