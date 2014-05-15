DROP TYPE IF EXISTS inventory.t_kickstarter_tier CASCADE;
CREATE TYPE inventory.t_kickstarter_tier AS (
    kickstarter_tier_id BIGINT
  , amount              INTEGER
  , tier_name           VARCHAR(255)
  , description         TEXT
  , total               BIGINT
);
ALTER TYPE inventory.t_kickstarter_tier OWNER TO store_db_su;
