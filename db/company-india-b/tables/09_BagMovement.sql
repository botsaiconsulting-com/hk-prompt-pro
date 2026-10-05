CREATE TABLE dbo.BagMovement (
    MovementId      int          IDENTITY(1,1) NOT NULL CONSTRAINT PK_BagMovement PRIMARY KEY,
    BagNo           varchar(12)  NOT NULL,
    StyleCode       varchar(12)  NOT NULL CONSTRAINT FK_BagMovement_Style REFERENCES dbo.StyleMaster (StyleCode),
    FromDept        varchar(20)  NOT NULL,
    ToDept          varchar(20)  NOT NULL,
    MovedAt         datetime2(0) NOT NULL,
    MetalWeightOutG decimal(9,3) NOT NULL,
    MetalWeightInG  decimal(9,3) NOT NULL
);
GO
