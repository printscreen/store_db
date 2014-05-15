DROP VIEW IF EXISTS transaction.v_paypal;
CREATE OR REPLACE VIEW transaction.v_paypal AS
SELECT
     p.paypal_id AS paypal_id
    ,p.insert_ts AS insert_ts
    ,p.user_id AS user_id
    ,p.order_status_id AS order_status_id
    ,os.name AS order_status_name
    ,p.shipping_cost AS shipping_cost
    ,p.ship_to AS ship_to
    ,p.bill_to AS bill_to
    ,u.email AS email
    ,p.token AS token
    ,p.cart AS cart
FROM transaction.paypal p
    INNER JOIN transaction.order_status os ON p.order_status_id = os.order_status_id
    INNER JOIN users.user u ON p.user_id = u.user_id;
ALTER VIEW transaction.v_paypal OWNER TO store_db_su;
