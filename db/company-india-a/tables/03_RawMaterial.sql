CREATE TABLE dbo.RawMaterial (
    ComponentCode varchar(20)   NOT NULL CONSTRAINT PK_RawMaterial PRIMARY KEY,
    ComponentType varchar(15)   NOT NULL CONSTRAINT CK_RawMaterial_Type CHECK (ComponentType IN ('METAL', 'DIAMOND', 'COLOUR_STONE', 'FINDING')),
    Description   nvarchar(100) NOT NULL,
    Uom           varchar(5)    NOT NULL,
    StdRate       decimal(12,2) NOT NULL
);
GO
