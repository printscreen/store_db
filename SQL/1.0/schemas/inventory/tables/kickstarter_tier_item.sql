DROP TABLE IF EXISTS inventory.kickstarter_tier_item CASCADE;
CREATE TABLE inventory.kickstarter_tier_item (
    kickstarter_tier_item_id    BIGSERIAL       PRIMARY KEY
  , kickstarter_item_id         BIGINT          NOT NULL REFERENCES inventory.kickstarter_item (kickstarter_item_id)
  , kickstarter_tier_id         BIGINT          NOT NULL REFERENCES inventory.kickstarter_tier (kickstarter_tier_id)
);
ALTER TABLE inventory.kickstarter_tier_item OWNER TO store_db_su;
ALTER TABLE inventory.kickstarter_tier_item ADD CONSTRAINT c_kickstarter_tier_item_kickstarter_item_id_kickstarter_tier_id UNIQUE (kickstarter_item_id,kickstarter_tier_id);
