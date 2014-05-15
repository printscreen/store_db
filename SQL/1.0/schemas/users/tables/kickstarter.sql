DROP TABLE IF EXISTS users.kickstarter CASCADE;
CREATE TABLE users.kickstarter (
    kickstarter_id  BIGSERIAL       PRIMARY KEY
  , tier_id         BIGINT          DEFAULT NULL REFERENCES inventory.kickstarter_tier (kickstarter_tier_id)
  , name            VARCHAR(255)    NOT NULL
  , first_name      VARCHAR(128)    DEFAULT NULL
  , last_name       VARCHAR(128)    DEFAULT NULL
  , password        VARCHAR(32)     DEFAULT NULL
  , email           VARCHAR(255)    NOT NULL UNIQUE
  , prefered_email  VARCHAR(255)    DEFAULT NULL UNIQUE
  , street          VARCHAR(128)    DEFAULT NULL
  , unit_number     VARCHAR(128)    DEFAULT NULL
  , city            VARCHAR(128)    DEFAULT NULL
  , state           VARCHAR(128)    DEFAULT NULL
  , postal_code     VARCHAR(128)    DEFAULT NULL
  , country_id      BIGINT          DEFAULT NULL REFERENCES transaction.country (country_id)
  , shirt_size      VARCHAR(4)      DEFAULT NULL
  , shirt_sex       VARCHAR(2)      DEFAULT NULL
  , notes           TEXT            DEFAULT NULL
  , hash            VARCHAR(255)    NOT NULL UNIQUE
  , last_sent_hash  TIMESTAMPTZ     DEFAULT NULL
  , update_ts       TIMESTAMPTZ     NOT NULL
  , verified        BOOLEAN         DEFAULT FALSE
);
ALTER TABLE users.kickstarter OWNER TO store_db_su;
