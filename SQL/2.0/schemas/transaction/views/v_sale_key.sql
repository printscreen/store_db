DROP VIEW IF EXISTS transaction.v_sale_key;
CREATE OR REPLACE VIEW transaction.v_sale_key AS
SELECT
     sk.sale_key_id AS sale_key_id
    ,sk.key AS key
    ,sk.order_id AS order_id
    ,o.user_id AS user_id
    ,sk.sale_item_id AS sale_item_id
    ,sk.item_id AS item_id
FROM transaction.sale_key sk
    INNER JOIN transaction.order o ON o.order_id = sk.order_id;
ALTER VIEW transaction.v_order OWNER TO store_db_su;
