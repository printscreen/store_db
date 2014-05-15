DROP TYPE IF EXISTS transaction.t_tax CASCADE;
CREATE TYPE transaction.t_tax AS (
    tax_id              BIGINT
  , postal_code         BIGINT
  , rate                DOUBLE PRECISION
  , active              BOOLEAN
  , update_ts           TIMESTAMPTZ
  , insert_ts           TIMESTAMPTZ
  , total               BIGINT
);
ALTER TYPE transaction.t_tax OWNER TO store_db_su;