DROP VIEW IF EXISTS transaction.v_item_ordered;
DROP VIEW IF EXISTS transaction.v_sale_item_ordered;
CREATE OR REPLACE VIEW transaction.v_sale_item_ordered AS
SELECT
     sio.sale_item_ordered_id AS sale_item_ordered_id
    ,sio.insert_ts AS insert_ts
    ,sio.update_ts AS update_ts
    ,sio.sale_item_id AS sale_item_id
    ,si.name AS sale_item_name
    ,sio.price_paid AS price_paid
    ,si.description AS description
    ,sio.order_id AS order_id
    ,sio.quantity AS quantity
    ,sio.active AS active
FROM transaction.sale_item_ordered sio
    INNER JOIN inventory.sale_item si ON sio.sale_item_id = si.sale_item_id;
ALTER VIEW transaction.v_sale_item_ordered OWNER TO store_db_su;