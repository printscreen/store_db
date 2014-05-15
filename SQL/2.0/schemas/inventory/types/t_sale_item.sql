DROP TYPE IF EXISTS inventory.t_sale_item CASCADE;
CREATE TYPE inventory.t_sale_item AS (
    sale_item_id        BIGINT
  , name                VARCHAR(128)
  , description         TEXT
  , price               BIGINT
  , insert_ts           TIMESTAMPTZ
  , active              BOOLEAN
  , total               BIGINT
);
ALTER TYPE inventory.t_sale_item OWNER TO store_db_su;