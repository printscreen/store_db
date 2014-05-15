DROP VIEW IF EXISTS inventory.v_item_file_path_orgin;
CREATE OR REPLACE VIEW inventory.v_item_file_path_orgin AS
SELECT
     ifpo.item_file_path_orgin_id AS item_file_path_orgin_id
    ,ifpo.name AS item_file_path_orgin_name
FROM inventory.item_file_path_orgin ifpo;
ALTER VIEW inventory.v_item_file_path_orgin OWNER TO store_db_su;
