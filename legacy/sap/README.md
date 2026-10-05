# SAP-era report (retired with SAP HANA, December 2025)

`reports/ZSD_MONTHLY_SALES_BY_CUST.sql` is a dummy version of an in-house SAP report that the team is rebuilding for Gati. `tables/` holds the SAP table definitions it reads, cut down to the fields it uses. There is no SAP data; the exercise is to map the old report onto the Gati structure in `db/` and rebuild it there.

`../gati-handwritten/monthly_sales_by_customer.sql` is the team's first hand-written Gati version, for comparison.
