DROP TYPE IF EXISTS transaction.t_item_ordered CASCADE;
DROP TYPE IF EXISTS transaction.t_sale_item_ordered CASCADE;
CREATE TYPE transaction.t_sale_item_ordered AS (
    sale_item_ordered_id    BIGINT
  , insert_ts               TIMESTAMPTZ
  , update_ts               TIMESTAMPTZ
  , sale_item_id            BIGINT
  , sale_item_name          VARCHAR(128)
  , description             VARCHAR(128)
  , price_paid              BIGINT
  , order_id                BIGINT
  , quantity                BIGINT
  , active                  BOOLEAN
  , total                   BIGINT
);
ALTER TYPE transaction.t_sale_item_ordered OWNER TO store_db_su;