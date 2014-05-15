DROP VIEW IF EXISTS transaction.v_sales_tax ;
CREATE OR REPLACE VIEW transaction.v_sales_tax AS
SELECT
     s.sales_tax_id AS sales_tax_id
    ,s.insert_ts AS insert_ts
    ,s.update_ts AS update_ts
    ,s.postal_code AS postal_code
    ,s.city AS city
    ,s.state AS state
    ,s.country_id AS country_id
    ,s.tax_rate AS tax_rate
FROM transaction.sales_tax s;
ALTER VIEW transaction.v_sales_tax OWNER TO store_db_su;
