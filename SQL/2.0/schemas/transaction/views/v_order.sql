DROP VIEW IF EXISTS transaction.v_order;
CREATE OR REPLACE VIEW transaction.v_order AS
SELECT
     o.order_id AS order_id
    ,o.insert_ts AS insert_ts
    ,o.transaction_id AS transaction_id
    ,o.order_number AS order_number
    ,o.user_id AS user_id
    ,o.order_status_id AS order_status_id
    ,os.name AS order_status_name
    ,o.shipping_cost AS shipping_cost
    ,o.ship_to AS ship_to
    ,o.bill_to AS bill_to
FROM transaction.order o
    INNER JOIN transaction.order_status os ON o.order_status_id = os.order_status_id;
ALTER VIEW transaction.v_order OWNER TO store_db_su;
