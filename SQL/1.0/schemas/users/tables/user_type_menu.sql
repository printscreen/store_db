DROP TABLE IF EXISTS users.user_type_menu CASCADE;
CREATE TABLE users.user_type_menu (
    user_type_menu_id         BIGSERIAL       PRIMARY KEY
  , user_type_id              BIGINT          NOT NULL REFERENCES users.user_type (user_type_id)
  , menu_id                   BIGINT          NOT NULL REFERENCES application.menu (menu_id)
);
ALTER TABLE users.user_type_menu OWNER TO store_db_su;
