USE [master];
GO

IF EXISTS (SELECT * FROM sys.sysdatabases WHERE[Name] = 'OrdersDatabase')
	BEGIN
		DROP DATABASE OrdersDatabase
	END;
GO

CREATE DATABASE OrdersDatabase;
GO
ALTER AUTHORIZATION ON DATABASE::OrdersDatabase TO [DESKTOP-RAOQCM2\���];
GO

USE OrdersDatabase;
GO

CREATE SCHEMA Sales;
GO

CREATE SCHEMA Person;
GO

CREATE SCHEMA Production;
GO

--Create Customers and populate table
CREATE TABLE Person.Customers
(CustomerID INT NOT NULL
,FirstName VARCHAR (50) NOT NULL
,LastName VARCHAR (50) NOT NULL
CONSTRAINT PK_Customers PRIMARY KEY (CustomerID));
GO

INSERT INTO Person.Customers
VALUES (1,'Lynn', 'Tsoflias')
INSERT INTO Person.Customers
VALUES (2,'Amy','Alberts')
INSERT INTO Person.Customers
VALUES (3,'Rachel','Valdez')
INSERT INTO Person.Customers
VALUES (4,'Jae','Pak');
GO

--Create CustomerDetails and populate table
CREATE TABLE Person.CustomerDetails
(CustomerID INT NOT NULL
,[Address] VARCHAR (50) NOT NULL
,City VARCHAR (50) NOT NULL
,PostalCode VARCHAR (50) NOT NULL
,DateOfBirth DATETIME NULL
CONSTRAINT PK_CustomerDetails PRIMARY KEY (CustomerID));
GO

--Add foreign key to CustomerDetails table
ALTER TABLE Person.CustomerDetails
ADD CONSTRAINT FK_CustomerDetails_Customers FOREIGN KEY (CustomerID)
REFERENCES Person.Customers (CustomerID);
GO
--Insert data into Person.CustomerDetails
INSERT INTO Person.CustomerDetails
VALUES (1,'1970 Napa Ct', 'Seattle','91932','06/02/1980')
INSERT INTO Person.CustomerDetails
VALUES (2,'9833 Mt. Dias Blv', 'Chicago','97321', '08/08/1966')
INSERT INTO Person.CustomerDetails
VALUES (3,'7484 Roundtree Drive','Boston', '94109','14/12/1967')
INSERT INTO Person.CustomerDetails
VALUES (4,'9539 Glenside Dr','Seattle','91977','23/05/1956');
GO

--Create and populate Orders table
CREATE TABLE Sales.Orders
(OrderID INT NOT NULL
,CustomerID INT NOT NULL
,OrderDate DATETIME NOT NULL
CONSTRAINT PK_Orders PRIMARY KEY (OrderID));
GO

--Add foreign key to Orders table
ALTER TABLE Sales.Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
REFERENCES Person.Customers (CustomerID);
GO

--Insert data into Orders
INSERT INTO Sales.Orders
VALUES (101,2, GETDATE())
INSERT INTO Sales.Orders
VALUES (102,3,GETDATE())
INSERT INTO Sales.Orders
VALUES (103,1,GETDATE())
INSERT INTO Sales.Orders
VALUES (104,4,GETDATE());
GO

--Create and populate Products table
CREATE TABLE Production.Products
(ProductID INT NOT NULL
,ProductName VARCHAR (50) NOT NULL
,Size VARCHAR (5) NOT NULL
,Color VARCHAR (25) NOT NULL
CONSTRAINT PK_Products PRIMARY KEY (ProductID));
GO

INSERT INTO Production.Products
VALUES (11,'Full-Finger Gloves, M', 'M', 'Black')
INSERT INTO Production.Products
VALUES (22,'Full-Finger Gloves, L', 'L', 'Black')
INSERT INTO Production.Products
VALUES (33,'Classic Vest, S', 'S', 'Yellow')
INSERT INTO Production.Products
VALUES (44,'Classic Vest, M', 'M', 'Yellow');
GO


USE OrdersDatabase;
GO

INSERT INTO Sales.LineItems
VALUES (101,11,15.00,1)
INSERT INTO Sales.LineItems
VALUES (101,44,30.00,1)
INSERT INTO Sales.LineItems
VALUES (102,44,30.00,1)
INSERT INTO Sales.LineItems
VALUES (103,33,30.00,2)
INSERT INTO Sales.LineItems
VALUES (103,22,15.00,1)
INSERT INTO Sales.LineItems
VALUES (104,44,30.00,1)
INSERT INTO Sales.LineItems
VALUES (104,11,15.00,1)
INSERT INTO Sales.LineItems
VALUES (104,33,30.00,1);
GO



USE OrdersDatabase;
GO
CREATE TABLE Sales.LineItems
(OrderID INT NOT NULL
,ProductID INT NOT NULL
,UnitPrice MONEY NOT NULL
,Quantity SMALLINT NOT NULL
CONSTRAINT PK_LineItems PRIMARY KEY (OrderID,ProductID)
CONSTRAINT FK_LineItems_Orders FOREIGN KEY (OrderID)
REFERENCES Sales.Orders (OrderID));
GO

ALTER TABLE Sales.Orders
ADD CONSTRAINT DF_OrderDate DEFAULT GETDATE() FOR OrderDate;
GO

INSERT INTO Sales.Orders
VALUES (110, 3, DEFAULT);
GO
SELECT * FROM Sales.Orders
WHERE OrderID = 110;
GO