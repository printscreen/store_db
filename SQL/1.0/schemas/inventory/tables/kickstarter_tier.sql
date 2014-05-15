DROP TABLE IF EXISTS inventory.kickstarter_tier CASCADE;
CREATE TABLE inventory.kickstarter_tier (
    kickstarter_tier_id BIGSERIAL       PRIMARY KEY
  , amount              INTEGER         NOT NULL
  , name                VARCHAR(255)    NOT NULL
  , description         TEXT            NOT NULL
);
ALTER TABLE inventory.kickstarter_tier OWNER TO store_db_su;
