DROP VIEW IF EXISTS transaction.v_order_history_type;
CREATE OR REPLACE VIEW transaction.v_order_history_type AS
SELECT
     ht.order_history_type_id AS order_history_type_id
    ,ht.name AS order_history_type_name
FROM transaction.order_history_type ht;
ALTER VIEW transaction.v_order_history_type OWNER TO store_db_su;
