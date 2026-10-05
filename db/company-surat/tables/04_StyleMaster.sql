CREATE TABLE dbo.StyleMaster (
    StyleCode        varchar(12)   NOT NULL CONSTRAINT PK_StyleMaster PRIMARY KEY,
    Description      nvarchar(100) NOT NULL,
    Category         varchar(20)   NOT NULL,
    MetalPurity      varchar(10)   NOT NULL,
    GrossWeightG     decimal(9,3)  NOT NULL,
    NetMetalWeightG  decimal(9,3)  NOT NULL
);
GO
