DROP VIEW IF EXISTS inventory.v_sale_group_sale_item;
CREATE OR REPLACE VIEW inventory.v_sale_group_sale_item AS
SELECT
     sgsi.sale_group_sale_item_id AS sale_group_sale_item_id
    ,sgsi.sale_group_id AS sale_group_id
    ,sg.name AS group_name
    ,sg.description AS group_description
    ,sg.insert_ts AS group_insert_ts
    ,sg.active AS group_active
    ,sgsi.sale_item_id AS sale_item_id
    ,si.name AS item_name
    ,si.description AS item_description
    ,si.price AS price
    ,si.insert_ts AS item_insert_ts
    ,si.active AS item_active
    , (SELECT min(i.quantity)
       FROM inventory.item i
       INNER JOIN inventory.sale_item_item sii ON sii.item_id = i.item_id
       WHERE sii.sale_item_id = sgsi.sale_item_id
       GROUP BY sgsi.sale_item_id) > 0 AS in_stock
    , (SELECT min(i.quantity / sii.quantity) AS num
        FROM inventory.sale_item_item sii
        INNER JOIN inventory.item i ON sii.item_id = i.item_id
        WHERE sii.sale_item_id = sgsi.sale_item_id) AS number_available
        FROM inventory.sale_group_sale_item sgsi
INNER JOIN inventory.sale_group sg ON sgsi.sale_group_id = sg.sale_group_id
INNER JOIN inventory.sale_item si ON sgsi.sale_item_id = si.sale_item_id;
ALTER VIEW inventory.v_sale_group_sale_item OWNER TO store_db_su;