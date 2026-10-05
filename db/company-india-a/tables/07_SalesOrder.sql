CREATE TABLE dbo.SalesOrder (
    OrderNo      varchar(12) NOT NULL CONSTRAINT PK_SalesOrder PRIMARY KEY,
    CompanyId    int         NOT NULL CONSTRAINT FK_SalesOrder_Company REFERENCES dbo.Company (CompanyId) ON DELETE CASCADE,
    CustomerCode varchar(10) NOT NULL CONSTRAINT FK_SalesOrder_Customer REFERENCES dbo.Customer (CustomerCode),
    OrderDate    date        NOT NULL,
    Status       char(1)     NOT NULL CONSTRAINT CK_SalesOrder_Status CHECK (Status IN ('O', 'I', 'C'))
);
GO
