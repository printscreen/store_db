DROP VIEW IF EXISTS transaction.v_order_tax;
CREATE OR REPLACE VIEW transaction.v_order_tax AS
SELECT
     ot.order_tax_id AS order_tax_id
    ,ot.order_id AS order_id
    ,ot.tax_id AS tax_id
    ,ot.rate AS rate
    ,ot.insert_ts AS insert_ts
FROM transaction.order_tax ot;
ALTER VIEW transaction.v_order_tax OWNER TO store_db_su;