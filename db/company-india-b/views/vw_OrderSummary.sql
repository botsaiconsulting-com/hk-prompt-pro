CREATE VIEW dbo.vw_OrderSummary
AS
SELECT o.OrderNo,
       o.OrderDate,
       o.CustCode,
       o.Status,
       SUM(l.Qty) AS Pieces,
       SUM(l.Qty * l.ProductionSalesPrice) AS OrderValue
FROM dbo.SalesOrder o
JOIN dbo.SalesOrderLine l ON l.OrderNo = o.OrderNo
GROUP BY o.OrderNo, o.OrderDate, o.CustCode, o.Status;
GO
