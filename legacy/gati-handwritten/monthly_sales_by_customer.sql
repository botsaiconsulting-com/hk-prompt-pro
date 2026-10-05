-- Monthly sales by customer, rebuilt for Gati by hand (September 2026).
-- Run once in each company database, then combine the results in Excel.
SELECT o.CustomerCode,
       c.CustomerName,
       FORMAT(o.OrderDate, 'yyyy-MM')      AS SalesMonth,
       SUM(l.Qty * l.ProductionSalesPrice) AS NetValue
FROM dbo.SalesOrder o
JOIN dbo.SalesOrderLine l ON l.OrderNo = o.OrderNo
JOIN dbo.Customer c       ON c.CustomerCode = o.CustomerCode
WHERE o.Status <> 'C'
  AND o.OrderDate BETWEEN '2026-07-01' AND '2026-09-30'
GROUP BY o.CustomerCode, c.CustomerName, FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY SalesMonth, NetValue DESC;
