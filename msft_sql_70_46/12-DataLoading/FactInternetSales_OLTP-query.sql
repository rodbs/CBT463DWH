SELECT
        dp.ProductKey AS [ProductKey], 
        (SELECT DateKey FROM [dbo].[DimDate] dt WHERE dt.FullDateAlternateKey = CONVERT(date, soh.OrderDate)) AS [OrderDateKey],
        (SELECT DateKey FROM [dbo].[DimDate] dt WHERE dt.FullDateAlternateKey = CONVERT(date, soh.DueDate)) AS [DueDateKey],
        (SELECT DateKey FROM [dbo].[DimDate] dt WHERE dt.FullDateAlternateKey = CONVERT(date, soh.ShipDate)) AS [ShipDateKey],
        soh.CustomerID AS [CustomerKey],
        sod.SpecialOfferID AS [PromotionKey] ,
        COALESCE(dc.CurrencyKey, 4250) AS [CurrencyKey],
        soh.TerritoryID AS [SalesTerritoryKey],
        soh.SalesOrderNumber AS [SalesOrderNumber], 
        ROW_NUMBER() OVER (PARTITION BY sod.SalesOrderID ORDER BY sod.SalesOrderDetailID) AS [SalesOrderLineNumber],
        soh.RevisionNumber AS [RevisionNumber],
        sod.OrderQty AS [OrderQuantity], 
        sod.UnitPrice AS [UnitPrice], 
        sod.OrderQty * sod.UnitPrice AS [ExtendedAmount], 
        sod.UnitPriceDiscount AS [UnitPriceDiscountPct], 
        sod.OrderQty * sod.UnitPrice * sod.UnitPriceDiscount AS [DiscountAmount], 
        pch.StandardCost AS [ProductStandardCost], 
        sod.OrderQty * pch.StandardCost AS [TotalProductCost], 
        sod.LineTotal AS [SalesAmount], 
        CONVERT(money, sod.LineTotal * 0.08) AS [TaxAmt],
        CONVERT(money, sod.LineTotal * 0.025) AS [Freight],
        sod.CarrierTrackingNumber AS [CarrierTrackingNumber],
        soh.PurchaseOrderNumber AS [CustomerPONumber],
		soh.OrderDate,
		soh.DueDate,
		soh.ShipDate
    FROM 
		[AdventureWorks2012].[Sales].[SalesOrderHeader] soh 
			INNER JOIN 
		[AdventureWorks2012].[Sales].[SalesOrderDetail] sod ON soh.[SalesOrderID] = sod.[SalesOrderID] AND soh.OnlineOrderFlag = 1
			INNER JOIN 
		[AdventureWorks2012].[Production].[Product] p ON sod.[ProductID] = p.[ProductID] 
			INNER JOIN 
		[AdventureWorks2012].[Sales].[Customer] c ON soh.[CustomerID] = c.[CustomerID]
			INNER JOIN 
		[dbo].[DimProduct] dp ON dp.[ProductAlternateKey] = p.[ProductNumber] AND [dbo].[udfMinimumDate](soh.[OrderDate], soh.[DueDate]) BETWEEN dp.[StartDate] AND COALESCE(dp.[EndDate], '12-31-9999')
			LEFT OUTER JOIN 
		[AdventureWorks2012].[Production].[ProductCostHistory] pch ON p.[ProductID] = pch.[ProductID] AND [dbo].[udfMinimumDate](soh.[OrderDate], soh.[DueDate]) BETWEEN pch.[StartDate] AND COALESCE(pch.[EndDate], '12-31-9999')
			LEFT OUTER JOIN 
		[AdventureWorks2012].[Sales].[CurrencyRate] cr ON soh.[CurrencyRateID] = cr.[CurrencyRateID] 
			LEFT OUTER JOIN 
		[dbo].[DimCurrency] dc ON cr.[ToCurrencyCode] = dc.[CurrencyAlternateKey]
			LEFT OUTER JOIN 
		[AdventureWorks2012].[HumanResources].[Employee] e ON soh.[SalesPersonID] = e.BusinessEntityID 
			LEFT OUTER JOIN 
		[dbo].[DimEmployee] de ON e.[NationalIDNumber] = de.[EmployeeNationalIDAlternateKey]