DROP VIEW IF EXISTS inventory.v_sale_item;
CREATE OR REPLACE VIEW inventory.v_sale_item AS
SELECT
     si.sale_item_id AS sale_item_id
    ,si.name AS name
    ,si.description AS description
    ,si.price AS price
    ,si.insert_ts AS insert_ts
    ,si.active AS active
FROM inventory.sale_item si;
ALTER VIEW inventory.v_sale_item OWNER TO store_db_su;