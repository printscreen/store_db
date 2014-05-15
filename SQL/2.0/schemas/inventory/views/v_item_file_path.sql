DROP VIEW IF EXISTS inventory.v_item_file_path;
CREATE OR REPLACE VIEW inventory.v_item_file_path AS
SELECT
     ifp.item_file_path_id AS item_file_path_id
    ,ifp.item_id AS item_id
    ,i.name AS item_name
    ,ifp.file_path AS file_path
    ,ifp.item_file_path_orgin_id AS item_file_path_orgin_id
    ,ifpo.name AS item_file_path_orgin_name
FROM inventory.item_file_path ifp
INNER JOIN inventory.item i ON ifp.item_id = i.item_id
INNER JOIN inventory.item_file_path_orgin ifpo ON ifp.item_file_path_orgin_id = ifpo.item_file_path_orgin_id;
ALTER VIEW inventory.v_item_file_path OWNER TO store_db_su;