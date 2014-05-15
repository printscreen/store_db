DROP TYPE IF EXISTS inventory.t_item CASCADE;
CREATE TYPE inventory.t_item AS (
    item_id             BIGINT
  , item_code           VARCHAR(128)
  , item_name           VARCHAR(128)
  , description         TEXT
  , price               BIGINT
  , item_price_id       BIGINT
  , quantity            BIGINT
  , item_quantity_id    BIGINT
  , weight_ounces       BIGINT
  , active              BOOLEAN
  , total               BIGINT
);
ALTER TYPE inventory.t_item OWNER TO store_db_su;
