CREATE PROCEDURE dbo.usp_ArchiveCompany
    @CompanyCode varchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    -- Used during the SAP to Gati migration to clear companies that were re-created.
    DELETE FROM dbo.Company WHERE CompanyCode = @CompanyCode;
END;
GO
