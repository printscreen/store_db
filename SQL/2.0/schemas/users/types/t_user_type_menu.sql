DROP TYPE IF EXISTS users.t_user_type_menu CASCADE;
CREATE TYPE users.t_user_type_menu AS (
    menu_name         VARCHAR(255)
  , url               VARCHAR(255)
  , group_name        VARCHAR(255)
  , user_type_id      BIGINT
  , total             BIGINT
);
ALTER TYPE users.t_user_type_menu OWNER TO store_db_su;