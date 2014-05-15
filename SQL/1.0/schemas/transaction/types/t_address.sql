DROP TYPE IF EXISTS transaction.t_address CASCADE;
CREATE TYPE transaction.t_address AS (
    address_id      BIGINT
  , insert_ts       TIMESTAMPTZ
  , update_ts       TIMESTAMPTZ
  , street          VARCHAR
  , unit_number     VARCHAR
  , city            VARCHAR
  , state           VARCHAR
  , postal_code     VARCHAR
  , country_id      BIGINT
  , country_name    VARCHAR(128)
  , country_code    VARCHAR(4)
  , user_id         BIGINT
  , first_name      VARCHAR(128)
  , last_name       VARCHAR(128)
  , active          BOOLEAN
  , hash            VARCHAR(255)
  , total           BIGINT
);
ALTER TYPE transaction.t_address OWNER TO store_db_su;
