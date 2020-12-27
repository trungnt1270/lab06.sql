USE master
IF EXISTS (SELECT * FROM sys.sysdatabases WHERE Name Like 'lab06')
	DROP DATABASE lab06

CREATE DATABASE lab06
GO
USE lab06

CREATE TABLE Ord(
	OrderID int IDENTITY,
	DateOrder date,
	CustomerID int,
	OrdStatus int,
	CONSTRAINT pk_ord PRIMARY KEY (OrderID)
)

CREATE TABLE OrderDetail(
	OrderID int,
	ProductID int,
	Quantity int,
	ProductPrice float,
	CONSTRAINT fk_ordid FOREIGN KEY (OrderID) REFERENCES Ord(OrderID)
)

CREATE TABLE Customer(
	CustomerID int IDENTITY,
	CustomerName nvarchar(50),
	Addres nvarchar(100),
	Tel varchar(10),
	CONSTRAINT pk_customerid PRIMARY KEY (CustomerID)
)

CREATE TABLE Product(
	ProductID int IDENTITY,
	ProductName nvarchar(100),
	ProductUnit int,
	ProductPrice money,
	ProductQuantity int,
	ProductStatus int,
	ProductDescription nvarchar(1000),
	CatID int,
	CONSTRAINT pk_productid PRIMARY KEY (ProductID)
)

CREATE TABLE Category(
	CategoryID int IDENTITY,
	CategoryName nvarchar(100),
	CONSTRAINT pk_categoryid PRIMARY KEY (CategoryID)
)
--3
INSERT INTO Customer(CustomerName,Addres,Tel) 
VALUES ('Nguyen Van An','111 Nguyen Trai, Thanh Xuan, Ha Noi','0987654321')

INSERT INTO Category(CategoryName) VALUES ('May Tinh'),('Dien Thoai'),('May In')

INSERT INTO Product(ProductName,ProductUnit,ProductPrice,ProductQuantity,ProductStatus,ProductDescription,CatID)
VALUES  ('May Tinh T450','1','1000','10',1,'May Nhap Moi','1'),
		('Dien Thoai Nokia 5670','1','200','10',1,'Dien Thoai Dang HOT','2'),
		('May In Samsung 450','1','100','10',1,'May In Dang E','3')

INSERT INTO Ord(DateOrder,CustomerID,OrdStatus)
VALUES  ('2019-01-01',1,1)

INSERT INTO OrderDetail(OrderID,ProductID,Quantity,ProductPrice)
VALUES  (1,1,1,'1000'),
		(1,2,2,'200'),
		(1,3,1,'100')
		
--4
SELECT * FROM Customer --a

SELECT * FROM Product --b

SELECT * FROM Ord --c

--5
SELECT * FROM Customer ORDER BY CustomerName --a

SELECT * FROM Product ORDER BY ProductPrice DESC --b

SELECT * FROM Ord INNER JOIN OrderDetail 
ON Ord.OrderID = OrderDetail.OrderID
WHERE CustomerID ='1' --c

--6
SELECT COUNT(CustomerID) 'Tong so khach hang da mua hang' 
FROM Ord GROUP BY CustomerID --a

SELECT COUNT(ProductID) FROM OrderDetail --b

SELECT SUM(ProductPrice) FROM OrderDetail GROUP BY OrderID --c

--7
ALTER TABLE Product
	ADD CONSTRAINT CHK_price CHECK (ProductPrice >0) --a

ALTER TABLE Ord
	ADD CONSTRAINT CHK_date CHECK (DateOrder<=GETDATE()) --b

ALTER TABLE Product
ADD AppearDate date --c