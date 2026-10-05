CREATE TABLE dbo.SalesOrderLine (
    OrderNo              varchar(12)   NOT NULL CONSTRAINT FK_SalesOrderLine_Order REFERENCES dbo.SalesOrder (OrderNo) ON DELETE CASCADE,
    LineNumber           smallint      NOT NULL,
    StyleCode            varchar(12)   NOT NULL CONSTRAINT FK_SalesOrderLine_Style REFERENCES dbo.StyleMaster (StyleCode),
    Qty                  int           NOT NULL,
    ProductionSalesPrice decimal(12,2) NOT NULL,
    ActualSellingPrice   decimal(12,2) NOT NULL,
    CONSTRAINT PK_SalesOrderLine PRIMARY KEY (OrderNo, LineNumber)
);
GO
