DROP TYPE IF EXISTS inventory.t_sale_item_item CASCADE;
CREATE TYPE inventory.t_sale_item_item AS (
    sale_item_item_id       BIGINT
  , sale_item_id            BIGINT
  , sale_item_item_quantity BIGINT
  , sale_name               VARCHAR(128)
  , sale_description        TEXT
  , price                   BIGINT
  , sale_insert_ts          TIMESTAMPTZ
  , sale_active             BOOLEAN
  , item_id                 BIGINT
  , code                    VARCHAR(128)
  , item_name               VARCHAR(128)
  , item_description        TEXT
  , weight_ounces           BIGINT
  , item_type_id            BIGINT
  , item_type_name          VARCHAR(128)
  , quantity                BIGINT
  , item_active             BOOLEAN
  , total                   BIGINT
);
ALTER TYPE inventory.t_sale_item_item OWNER TO store_db_su;