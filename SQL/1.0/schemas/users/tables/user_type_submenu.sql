DROP TABLE IF EXISTS users.user_type_submenu CASCADE;
CREATE TABLE users.user_type_submenu (
    user_type_submenu_id      BIGSERIAL       PRIMARY KEY
  , user_type_id              BIGINT          NOT NULL REFERENCES users.user_type (user_type_id)
  , submenu_id                BIGINT          NOT NULL REFERENCES application.submenu (submenu_id)
);
ALTER TABLE users.user_type_submenu OWNER TO store_db_su;
