DROP VIEW IF EXISTS inventory.v_item_type;
CREATE OR REPLACE VIEW inventory.v_item_type AS
SELECT
     it.item_type_id AS item_type_id
    ,it.name AS item_type_name
FROM inventory.item_type it;
ALTER VIEW inventory.v_item_type OWNER TO store_db_su;
