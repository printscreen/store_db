DROP TYPE IF EXISTS inventory.t_sale_group_sale_item CASCADE;
CREATE TYPE inventory.t_sale_group_sale_item AS (
    sale_group_sale_item_id BIGINT
  , sale_group_id           BIGINT
  , group_name              VARCHAR(128)
  , group_description       TEXT
  , group_insert_ts         TIMESTAMPTZ
  , group_active            BOOLEAN
  , sale_item_id            BIGINT
  , item_name               VARCHAR(128)
  , item_description        TEXT
  , price                   BIGINT
  , item_insert_ts          TIMESTAMPTZ
  , item_active             BOOLEAN
  , in_stock                BOOLEAN
  , number_available        BIGINT
  , total                   BIGINT
);
ALTER TYPE inventory.t_sale_group_sale_item OWNER TO store_db_su;