CREATE TABLE dbo.ClientStyle (
    ClientStyleCode varchar(20)  NOT NULL CONSTRAINT PK_ClientStyle PRIMARY KEY,
    StyleCode       varchar(12)  NOT NULL CONSTRAINT FK_ClientStyle_Style REFERENCES dbo.StyleMaster (StyleCode),
    CustomerCode    varchar(10)  NOT NULL CONSTRAINT FK_ClientStyle_Customer REFERENCES dbo.Customer (CustomerCode),
    ClientRef       nvarchar(40) NULL
);
GO
