DROP TYPE IF EXISTS users.t_user_type CASCADE;
CREATE TYPE users.t_user_type AS (
    user_type_id      BIGINT
  , user_type_name    VARCHAR(32)
  , total             BIGINT
);
ALTER TYPE users.t_user_type OWNER TO store_db_su;
