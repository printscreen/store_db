DROP VIEW IF EXISTS inventory.v_kickstarter_tier;
CREATE OR REPLACE VIEW inventory.v_kickstarter_tier AS
SELECT
     kt.kickstarter_tier_id AS kickstarter_tier_id
    ,kt.amount AS amount
    ,kt.name AS tier_name
    ,kt.description AS description
FROM inventory.kickstarter_tier kt;
ALTER VIEW inventory.v_kickstarter_tier OWNER TO store_db_su;