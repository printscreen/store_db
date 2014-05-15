DROP TYPE IF EXISTS users.t_user_type_resource CASCADE;
CREATE TYPE users.t_user_type_resource AS (
    user_type_resource_id    BIGINT
  , user_type_id             BIGINT
  , user_type_name           VARCHAR(32)
  , resource_id              BIGINT
  , resource_name            VARCHAR(255)
);
ALTER TYPE users.t_user_type_resource OWNER TO store_db_su;
