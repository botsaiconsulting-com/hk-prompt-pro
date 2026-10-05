CREATE PROCEDURE dbo.usp_GetCustomerOrders
    @CustomerCode varchar(10),
    @From date,
    @To   date
AS
BEGIN
    SET NOCOUNT ON;
    SELECT o.OrderNo, o.OrderDate, o.Status, l.LineNumber, l.StyleCode, l.Qty, l.ActualSellingPrice
    FROM dbo.SalesOrder o
    JOIN dbo.SalesOrderLine l ON l.OrderNo = o.OrderNo
    WHERE o.CustCode = @CustomerCode
      AND o.OrderDate >= @From
      AND o.OrderDate <  @To
    ORDER BY o.OrderDate, o.OrderNo, l.LineNumber;
END;
GO
