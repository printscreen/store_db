DROP VIEW IF EXISTS inventory.v_sale_group;
CREATE OR REPLACE VIEW inventory.v_sale_group AS
SELECT
     sg.sale_group_id AS sale_group_id
    ,sg.name AS name
    ,sg.description AS description
    ,sg.url AS url
    ,sg.insert_ts AS insert_ts
    ,sg.active AS active
    ,sgp.thumbnail_path AS thumbnail
FROM inventory.sale_group sg
LEFT JOIN (
    SELECT sale_group_id, thumbnail_path FROM inventory.sale_group_picture WHERE primary_picture
)sgp ON sgp.sale_group_id = sg.sale_group_id;
ALTER VIEW inventory.v_sale_group OWNER TO store_db_su;