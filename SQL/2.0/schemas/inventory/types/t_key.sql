DROP TYPE IF EXISTS inventory.t_key CASCADE;
CREATE TYPE inventory.t_key AS (
    key_id              BIGINT
  , key                 TEXT
  , item_id             BIGINT
  , item_name           VARCHAR(128)
  , user_id             BIGINT
  , user_name           VARCHAR(255)
  , insert_ts           TIMESTAMPTZ
  , total               BIGINT
);
ALTER TYPE inventory.t_key OWNER TO store_db_su;
