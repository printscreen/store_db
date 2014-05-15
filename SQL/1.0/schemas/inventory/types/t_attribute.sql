DROP TYPE IF EXISTS inventory.t_attribute CASCADE;
CREATE TYPE inventory.t_attribute AS (
    attribute_id        BIGINT
  , attribute_name      VARCHAR(128)
  , parent_id           BIGINT
  , total               BIGINT
);
ALTER TYPE inventory.t_attribute OWNER TO store_db_su;
