DROP TYPE IF EXISTS transaction.t_sale_key CASCADE;
CREATE TYPE transaction.t_sale_key AS (
    sale_key_id         BIGINT
  , key                 TEXT
  , order_id            BIGINT
  , user_id             BIGINT
  , sale_item_id        BIGINT
  , item_id             BIGINT
  , total               BIGINT
);
ALTER TYPE transaction.t_sale_key OWNER TO store_db_su;