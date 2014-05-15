DROP VIEW IF EXISTS inventory.v_get_out_of_stock_sale_item;
CREATE OR REPLACE VIEW inventory.v_get_out_of_stock_sale_item AS
SELECT
     si.sale_item_id AS sale_item_id
    ,si.name AS name
    ,si.description AS description
    ,si.price AS price
    ,si.insert_ts AS insert_ts
    ,si.active AS active
FROM inventory.sale_item si
INNER JOIN (
    SELECT sii.sale_item_id
    FROM inventory.sale_item_item sii
    INNER JOIN inventory.item i ON sii.item_id = i.item_id
    WHERE i.quantity < sii.quantity
) v ON v.sale_item_id = si.sale_item_id;
ALTER VIEW inventory.v_get_out_of_stock_sale_item OWNER TO store_db_su;