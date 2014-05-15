DROP VIEW IF EXISTS transaction.v_order_status;
CREATE OR REPLACE VIEW transaction.v_order_status AS
SELECT
     os.order_status_id AS order_status_id
    ,os.name AS order_status_name
FROM transaction.order_status os;
ALTER VIEW transaction.v_order_status OWNER TO store_db_su;
