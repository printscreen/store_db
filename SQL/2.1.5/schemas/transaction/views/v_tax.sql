DROP VIEW IF EXISTS transaction.v_tax;
CREATE OR REPLACE VIEW transaction.v_tax AS
SELECT
     t.tax_id AS tax_id
    ,t.postal_code AS postal_code
    ,t.rate AS rate
    ,t.active AS active
    ,t.update_ts AS update_ts
    ,t.insert_ts AS insert_ts
FROM transaction.tax t;
ALTER VIEW transaction.v_tax OWNER TO store_db_su;