# 02 SQL and API that know the schema (Theme 1)

1. `/hk orient .` Read the `## Working at HK` section it wrote to `CLAUDE.md` and correct anything wrong.
2. `/hk schema orders`. Read the "Across the three companies" and "Traps" sections first. Which of them would break a report written for one company database?
3. `/hk schema VBAK vs SalesOrder`, then `/hk schema VBAP vs SalesOrderLine` and `/hk schema KNA1 vs Customer`, using `legacy/sap/`. Read the `missing` and `type change` rows first.
4. `/hk sql "monthly net sales by customer, July to September 2026, across all three companies, as the SAP report ZSD_MONTHLY_SALES_BY_CUST did"`. Read the join explanation before the query. Run the query and its checks with the read-only login.
5. Compare with `legacy/gati-handwritten/monthly_sales_by_customer.sql`. Which numbers differ, and why?
6. `/hk endpoint sql/<your file>.sql`. Approve the plan only if it names the files and a branch.
7. `/hk check context/schema/orders.md`.

Human check: you can say which price column the report must use and why the hand-written version gives a different total.
