DROP TYPE IF EXISTS inventory.t_sale_group CASCADE;
CREATE TYPE inventory.t_sale_group AS (
    sale_group_id       BIGINT
  , name                VARCHAR(128)
  , description         TEXT
  , url                 VARCHAR(255)
  , thumbnail           VARCHAR(255)
  , insert_ts           TIMESTAMPTZ
  , active              BOOLEAN
  , total               BIGINT
);
ALTER TYPE inventory.t_sale_group OWNER TO store_db_su;