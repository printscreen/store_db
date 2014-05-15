DROP VIEW IF EXISTS inventory.v_item;
CREATE OR REPLACE VIEW inventory.v_item AS
SELECT
     i.item_id AS item_id
    ,i.code AS item_code
    ,i.name AS item_name
    ,i.item_type_id AS item_type_id
    ,it.name AS item_type_name
    ,i.description AS description
    ,i.quantity AS quantity
    ,i.weight_ounces AS weight_ounces
    ,i.active AS active
FROM inventory.item i
INNER JOIN inventory.item_type it ON i.item_type_id = it.item_type_id;
ALTER VIEW inventory.v_item OWNER TO store_db_su;