DROP TYPE IF EXISTS transaction.t_item_ordered CASCADE;
CREATE TYPE transaction.t_item_ordered AS (
    item_ordered_id BIGINT
  , insert_ts       TIMESTAMPTZ
  , update_ts       TIMESTAMPTZ
  , item_id         BIGINT
  , item_code       VARCHAR(128)
  , item_name       VARCHAR(128)
  , description     VARCHAR(128)
  , order_id        BIGINT
  , quantity        BIGINT
  , active          BOOLEAN
  , total           BIGINT
);
ALTER TYPE transaction.t_item_ordered OWNER TO store_db_su;
