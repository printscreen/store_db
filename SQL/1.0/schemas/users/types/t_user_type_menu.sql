DROP TYPE IF EXISTS users.t_user_type_menu CASCADE;
CREATE TYPE users.t_user_type_menu AS (
    user_type_menu_id        BIGINT
  , user_type_id             BIGINT
  , user_type_name           VARCHAR(32)
  , menu_id                  BIGINT
  , menu_name                VARCHAR(255)
  , url                      VARCHAR(255)
  , module                   VARCHAR(255)
  , controller               VARCHAR(255)
  , action                   VARCHAR(255)
);
ALTER TYPE users.t_user_type_menu OWNER TO store_db_su;
