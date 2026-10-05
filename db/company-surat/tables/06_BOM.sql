CREATE TABLE dbo.BOM (
    BomId         int          IDENTITY(1,1) NOT NULL CONSTRAINT PK_BOM PRIMARY KEY,
    StyleCode     varchar(12)  NOT NULL CONSTRAINT FK_BOM_Style REFERENCES dbo.StyleMaster (StyleCode),
    ComponentCode varchar(20)  NOT NULL CONSTRAINT FK_BOM_Component REFERENCES dbo.RawMaterial (ComponentCode),
    Qty           decimal(9,3) NOT NULL,
    WeightG       decimal(9,3) NULL,
    Carats        decimal(9,3) NULL,
    CONSTRAINT UQ_BOM_Style_Component UNIQUE (StyleCode, ComponentCode)
);
GO
