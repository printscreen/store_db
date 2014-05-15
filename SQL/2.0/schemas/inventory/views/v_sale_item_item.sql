DROP VIEW IF EXISTS inventory.v_sale_item_item;
CREATE OR REPLACE VIEW inventory.v_sale_item_item AS
SELECT
     sii.sale_item_item_id AS sale_item_item_id
    ,sii.sale_item_id AS sale_item_id
    ,sii.quantity AS sale_item_item_quantity
    ,si.name AS sale_name
    ,si.description AS sale_description
    ,si.price AS price
    ,si.insert_ts AS sale_insert_ts
    ,si.active AS sale_active
    ,sii.item_id AS item_id
    ,i.code AS code
    ,i.name AS item_name
    ,i.description AS item_description
    ,i.weight_ounces AS weight_ounces
    ,i.item_type_id AS item_type_id
    ,it.name AS item_type_name
    ,sii.quantity AS quantity
    ,i.active AS item_active
FROM inventory.sale_item_item sii
INNER JOIN inventory.sale_item si ON sii.sale_item_id = si.sale_item_id
INNER JOIN inventory.item i ON sii.item_id = i.item_id
INNER JOIN inventory.item_type it ON it.item_type_id = i.item_type_id;
ALTER VIEW inventory.v_sale_item_item OWNER TO store_db_su;