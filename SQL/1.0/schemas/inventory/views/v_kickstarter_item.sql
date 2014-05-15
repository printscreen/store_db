DROP VIEW IF EXISTS inventory.v_kickstarter_item;
CREATE OR REPLACE VIEW inventory.v_kickstarter_item AS
SELECT
     ki.kickstarter_item_id AS kickstarter_item_id
    ,ki.name AS item_name
    ,ki.description AS description
    ,ki.is_physical_item AS is_physical_item
FROM inventory.kickstarter_item ki;
ALTER VIEW inventory.v_kickstarter_item OWNER TO store_db_su;