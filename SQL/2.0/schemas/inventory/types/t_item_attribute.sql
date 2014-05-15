DROP TYPE IF EXISTS inventory.t_item_attribute CASCADE;
CREATE TYPE inventory.t_item_attribute AS (
    item_attribute_id   BIGINT
  , item_id             BIGINT
  , item_code           VARCHAR(128)
  , item_name           VARCHAR(128)
  , description         VARCHAR(128)
  , weight_ounces       BIGINT
  , quantity            BIGINT
  , attribute_id        BIGINT
  , attribute_name      BIGINT
  , attribute_parent_id BIGINT
  , active              BOOLEAN
  , total               BIGINT
);
ALTER TYPE inventory.t_item_attribute OWNER TO store_db_su;