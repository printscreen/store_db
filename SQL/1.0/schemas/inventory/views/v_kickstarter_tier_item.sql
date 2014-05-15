DROP VIEW IF EXISTS inventory.v_kickstarter_tier_item;
CREATE OR REPLACE VIEW inventory.v_kickstarter_tier_item AS
SELECT
     kti.kickstarter_tier_item_id AS kickstarter_tier_item_id
    ,kti.kickstarter_item_id AS kickstarter_item_id
    ,ki.name AS item_name
    ,ki.description AS item_description
    ,ki.is_physical_item AS is_physical_item
    ,kti.kickstarter_tier_id AS kickstarter_tier_id
    ,kt.amount AS amount
    ,kt.name AS tier_name
    ,kt.description AS tier_description
FROM inventory.kickstarter_tier_item kti
    INNER JOIN inventory.kickstarter_item ki ON kti.kickstarter_item_id = ki.kickstarter_item_id
    INNER JOIN inventory.kickstarter_tier kt ON kti.kickstarter_tier_id = kt.kickstarter_tier_id;
ALTER VIEW inventory.v_kickstarter_tier_item OWNER TO store_db_su;