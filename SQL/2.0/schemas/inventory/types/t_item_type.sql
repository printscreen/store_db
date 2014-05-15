DROP TYPE IF EXISTS inventory.t_item_type CASCADE;
CREATE TYPE inventory.t_item_type AS (
    item_type_id      BIGINT
  , item_type_name    VARCHAR(32)
  , total             BIGINT
);
ALTER TYPE inventory.t_item_type OWNER TO store_db_su;
