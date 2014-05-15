DROP VIEW IF EXISTS transaction.v_digital_item;
CREATE OR REPLACE VIEW transaction.v_digital_item AS
SELECT
     i.item_id AS item_id
    ,i.name AS name
    ,i.active AS active
    ,i.description AS description
    ,ifp.file_path AS file_path
    ,ifp.item_file_path_orgin_id AS file_path_orgin_id
    ,ifpo.name AS file_path_orgin_name
FROM inventory.item i
    INNER JOIN inventory.item_file_path ifp ON ifp.item_id = i.item_id
    INNER JOIN inventory.item_file_path_orgin ifpo ON ifpo.item_file_path_orgin_id = ifp.item_file_path_orgin_id
WHERE i.item_type_id = 2;
ALTER VIEW transaction.v_digital_item OWNER TO store_db_su;