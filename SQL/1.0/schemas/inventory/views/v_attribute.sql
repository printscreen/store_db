DROP VIEW IF EXISTS inventory.v_attribute;
CREATE OR REPLACE VIEW inventory.v_attribute AS
SELECT
     a.attribute_id AS attribute_id
    ,a.name AS attribute_name
    ,a.parent_id AS parent_id
FROM inventory.attribute a;
ALTER VIEW inventory.v_attribute OWNER TO store_db_su;
