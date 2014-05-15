DROP TYPE IF EXISTS transaction.t_order_tax CASCADE;
CREATE TYPE transaction.t_order_tax AS (
    order_tax_id        BIGINT
  , order_id            BIGINT
  , tax_id              BIGINT
  , rate                DOUBLE PRECISION
  , insert_ts           TIMESTAMPTZ
  , total               BIGINT
);
ALTER TYPE transaction.t_order_tax OWNER TO store_db_su;