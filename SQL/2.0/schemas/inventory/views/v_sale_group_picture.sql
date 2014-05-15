DROP VIEW IF EXISTS inventory.v_sale_group_picture;
CREATE OR REPLACE VIEW inventory.v_sale_group_picture AS
SELECT
     sgp.sale_group_picture_id AS sale_group_picture_id
    ,sgp.sale_group_id AS sale_group_id
    ,sgp.file_path AS file_path
    ,sgp.thumbnail_path AS thumbnail_path
    ,sgp.alt_text AS alt_text
    ,sgp.primary_picture AS primary_picture
FROM inventory.sale_group_picture sgp;
ALTER VIEW inventory.v_sale_group_picture OWNER TO store_db_su;