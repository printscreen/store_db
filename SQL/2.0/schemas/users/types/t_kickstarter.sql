DROP TYPE IF EXISTS users.t_kickstarter CASCADE;
CREATE TYPE users.t_kickstarter AS (
    kickstarter_id  BIGINT
  , tier_id         BIGINT
  , name            VARCHAR(255)
  , first_name      VARCHAR(128)
  , last_name       VARCHAR(128)
  , password        VARCHAR(32)
  , email           VARCHAR(255)
  , prefered_email  VARCHAR(255)
  , user_id         BIGINT
  , order_id        BIGINT
  , address_id      BIGINT
  , street          VARCHAR(128)
  , unit_number     VARCHAR(128)
  , city            VARCHAR(128)
  , state           VARCHAR(128)
  , postal_code     VARCHAR(128)
  , country_id      BIGINT
  , country_name    VARCHAR(128)
  , country_code    VARCHAR(4)
  , phone_number    VARCHAR(100)
  , shirt_size      VARCHAR(4)
  , shirt_sex       VARCHAR(2)
  , notes           TEXT
  , hash            VARCHAR(255)
  , last_sent_hash  TIMESTAMPTZ
  , update_ts       TIMESTAMPTZ
  , verified        BOOLEAN
  , total           BIGINT
);
ALTER TYPE users.t_kickstarter OWNER TO store_db_su;