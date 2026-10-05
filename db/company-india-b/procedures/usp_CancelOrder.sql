CREATE PROCEDURE dbo.usp_CancelOrder
    @OrderNo varchar(12)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.SalesOrder SET Status = 'C' WHERE OrderNo = @OrderNo;
END;
GO
