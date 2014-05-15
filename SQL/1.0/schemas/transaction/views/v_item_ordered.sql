DROP VIEW IF EXISTS transaction.v_item_ordered;
CREATE OR REPLACE VIEW transaction.v_item_ordered AS
SELECT
     io.item_ordered_id AS item_ordered_id
    ,io.insert_ts AS insert_ts
    ,io.update_ts AS update_ts
    ,io.item_id AS item_id
    ,i.code AS item_code
    ,i.name AS item_name
    ,i.description AS description
    ,io.order_id AS order_id
    ,io.quantity AS quantity
    ,io.active AS active
FROM transaction.item_ordered io
    LEFT JOIN inventory.item i ON io.item_id = i.item_id;
ALTER VIEW transaction.v_item_ordered OWNER TO store_db_su;
