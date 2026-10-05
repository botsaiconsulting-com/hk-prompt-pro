-- ZSD_MONTHLY_SALES_BY_CUST
-- In-house report on SAP HANA, retired December 2025. Monthly net sales by customer for one company code.
-- Parameters: :P_BUKRS company code; :P_FROM and :P_TO as YYYYMMDD.
SELECT
    a.BUKRS_VF               AS company_code,
    a.KUNNR                  AS customer,
    k.NAME1                  AS customer_name,
    SUBSTRING(a.ERDAT, 1, 6) AS period_yyyymm,
    SUM(p.NETWR)             AS net_value,
    a.WAERK                  AS currency
FROM VBAK a
INNER JOIN VBAP p ON p.MANDT = a.MANDT AND p.VBELN = a.VBELN
INNER JOIN KNA1 k ON k.MANDT = a.MANDT AND k.KUNNR = a.KUNNR
WHERE a.MANDT = '100'
  AND a.BUKRS_VF = :P_BUKRS
  AND a.ERDAT BETWEEN :P_FROM AND :P_TO
  AND a.AUART IN ('ZOR', 'ZEX')     -- standard and export orders only
  AND p.ABGRU = ''                   -- rejected items excluded
GROUP BY a.BUKRS_VF, a.KUNNR, k.NAME1, SUBSTRING(a.ERDAT, 1, 6), a.WAERK
ORDER BY period_yyyymm, net_value DESC;
