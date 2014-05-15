DROP TYPE IF EXISTS inventory.t_kickstarter_tier_item CASCADE;
CREATE TYPE inventory.t_kickstarter_tier_item AS (
    kickstarter_tier_item_id    BIGINT
  , kickstarter_item_id         BIGINT
  , item_name                   VARCHAR(255)
  , item_description            TEXT
  , is_physical_item            BOOLEAN
  , kickstarter_tier_id         BIGINT
  , tier_name                   VARCHAR(255)
  , tier_description            TEXT
  , amount                      INTEGER
  , total                       BIGINT
);
ALTER TYPE inventory.t_kickstarter_tier_item OWNER TO store_db_su;
