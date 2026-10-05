-- Known-answer test: every company database carries the same five customer codes.
SET NOCOUNT ON;
SELECT CASE WHEN COUNT(*) = 5 THEN 'PASS' ELSE 'FAIL' END + ' HK_SURAT customer count = ' + CAST(COUNT(*) AS varchar(10))
FROM HK_SURAT.dbo.Customer;
SELECT CASE WHEN COUNT(*) = 5 THEN 'PASS' ELSE 'FAIL' END + ' HK_INDIA_A customer count = ' + CAST(COUNT(*) AS varchar(10))
FROM HK_INDIA_A.dbo.Customer;
SELECT CASE WHEN COUNT(*) = 5 THEN 'PASS' ELSE 'FAIL' END + ' HK_INDIA_B customer count = ' + CAST(COUNT(*) AS varchar(10))
FROM HK_INDIA_B.dbo.Customer;
