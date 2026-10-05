CREATE TABLE dbo.Customer (
    CustomerCode varchar(10)   NOT NULL CONSTRAINT PK_Customer PRIMARY KEY,
    CustomerName nvarchar(100) NOT NULL,
    City         nvarchar(60)  NULL,
    Country      nvarchar(60)  NULL
);
GO
