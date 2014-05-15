DROP TYPE IF EXISTS transaction.t_country CASCADE;
CREATE TYPE transaction.t_country AS (
    country_id      BIGINT
  , country_name    VARCHAR(128)
  , country_code    VARCHAR(4)
  , active          BOOLEAN
  , total           BIGINT
);
ALTER TYPE transaction.t_country OWNER TO store_db_su;
