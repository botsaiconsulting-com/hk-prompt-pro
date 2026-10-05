CREATE TABLE dbo.Company (
    CompanyId    int           NOT NULL CONSTRAINT PK_Company PRIMARY KEY,
    CompanyCode  varchar(10)   NOT NULL CONSTRAINT UQ_Company_CompanyCode UNIQUE,
    CompanyName  nvarchar(100) NOT NULL,
    IsActive     bit           NOT NULL CONSTRAINT DF_Company_IsActive DEFAULT (1)
);
GO
