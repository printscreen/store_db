DROP VIEW IF EXISTS inventory.v_item;
CREATE OR REPLACE VIEW inventory.v_item AS
SELECT
     i.item_id AS item_id
    ,i.code AS item_code
    ,i.name AS item_name
    ,i.description AS description
    ,q.item_quantity_id AS item_quantity_id
    ,q.quantity AS quantity
    ,p.item_price_id AS item_price_id
    ,p.price AS price
    ,i.weight_ounces AS weight_ounces
    ,i.active AS active
FROM inventory.item i
    LEFT JOIN inventory.item_price p ON i.item_id = p.item_id
    LEFT JOIN inventory.item_quantity q ON i.item_id = q.item_id;
ALTER VIEW inventory.v_item OWNER TO store_db_su;
