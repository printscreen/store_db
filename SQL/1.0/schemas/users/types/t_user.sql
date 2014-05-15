DROP TYPE IF EXISTS users.t_user CASCADE;
CREATE TYPE users.t_user AS (
    user_id           BIGINT
  , insert_ts         TIMESTAMPTZ
  , update_ts         TIMESTAMPTZ
  , first_name        VARCHAR(128)
  , last_name         VARCHAR(128)
  , email             VARCHAR(255)
  , user_type_id      BIGINT
  , user_type_name    VARCHAR(32)
  , active            BOOLEAN
  , total             BIGINT
);
ALTER TYPE users.t_user OWNER TO store_db_su;
