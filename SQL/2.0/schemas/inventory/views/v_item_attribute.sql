DROP VIEW IF EXISTS inventory.v_item_attribute;
CREATE OR REPLACE VIEW inventory.v_item_attribute AS
SELECT
     ia.item_attribute_id AS item_attribute_id
    ,ia.item_id AS item_id
    ,i.code AS item_code
    ,i.name AS item_name
    ,i.description AS description
    ,i.weight_ounces AS weight_ounces
    ,i.quantity AS quantity
    ,i.active AS active
    ,ia.attribute_id AS attribute_id
    ,a.name AS attribute_name
    ,a.parent_id AS attribute_parent_id
FROM inventory.item_attribute ia
    INNER JOIN inventory.item i ON i.item_id = ia.item_id
    INNER JOIN inventory.attribute a ON a.attribute_id = ia.attribute_id;
ALTER VIEW inventory.v_item_attribute OWNER TO store_db_su;