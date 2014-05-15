DROP VIEW IF EXISTS transaction.v_user_digital_item;
CREATE OR REPLACE VIEW transaction.v_user_digital_item AS
SELECT DISTINCT
     i.item_id AS item_id
    ,o.user_id AS user_id
    ,o.order_id AS order_id
    ,o.order_number AS order_number
    ,sii.sale_item_id AS sale_item_id
    ,i.name AS name
    ,i.active AS active
    ,i.description AS description
    ,ifp.file_path AS file_path
    ,ifp.item_file_path_orgin_id AS file_path_orgin_id
    ,ifpo.name AS file_path_orgin_name
FROM transaction.order o
    INNER JOIN transaction.sale_item_ordered sio ON sio.order_id = o.order_id
    INNER JOIN inventory.sale_item_item sii ON sio.sale_item_id = sii.sale_item_id
    INNER JOIN inventory.item i ON sii.item_id = i.item_id
    LEFT JOIN inventory.item_file_path ifp ON ifp.item_id = sii.item_id
    LEFT JOIN inventory.item_file_path_orgin ifpo ON ifpo.item_file_path_orgin_id = ifp.item_file_path_orgin_id
WHERE i.item_type_id = 2
AND sio.active;
ALTER VIEW transaction.v_user_digital_item OWNER TO store_db_su;