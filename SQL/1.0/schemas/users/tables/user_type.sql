DROP TABLE IF EXISTS users.user_type CASCADE;
CREATE TABLE users.user_type (
    user_type_id              BIGSERIAL       PRIMARY KEY
  , user_type_name            VARCHAR(32)     NOT NULL
);
ALTER TABLE users.user_type OWNER TO store_db_su;
