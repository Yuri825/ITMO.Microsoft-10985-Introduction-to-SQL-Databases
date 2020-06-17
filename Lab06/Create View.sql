
USE OrdersDatabase;
GO

SELECT (FirstName + ' ' + LastName) AS [Customer Name] 
,O.OrderID, OrderDate
,SUM(UnitPrice*Quantity) AS [Order Total] 
FROM Person.Customers as C
JOIN Sales.Orders as O 
ON C.CustomerID = O.CustomerID
JOIN Sales.LineItems as L
ON O.OrderID = L.OrderID
GROUP BY O.OrderID, Firstname, Lastname, OrderDate;
GO



USE OrdersDatabase;
GO

CREATE VIEW VW_CustomerOrders
AS
SELECT (FirstName + ' ' + LastName) AS [Customer Name] 
,O.OrderID, OrderDate
,SUM(UnitPrice*Quantity) AS [Order Total] 
FROM Person.Customers as C
JOIN Sales.Orders as O 
ON C.CustomerID = O.CustomerID
JOIN Sales.LineItems as L
ON O.OrderID = L.OrderID
GROUP BY O.OrderID, Firstname, Lastname, OrderDate;
GO


SELECT * FROM VW_CustomerOrders;
GO