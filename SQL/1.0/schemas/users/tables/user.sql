DROP TABLE IF EXISTS users.user CASCADE;
CREATE TABLE users.user (
    user_id         BIGSERIAL       PRIMARY KEY
  , insert_ts       TIMESTAMPTZ     NOT NULL DEFAULT NOW()
  , update_ts       TIMESTAMPTZ     NOT NULL
  , first_name      VARCHAR(128)    NULL
  , last_name       VARCHAR(128)    NULL
  , email           VARCHAR(255)    NOT NULL
  , password        VARCHAR(32)     -- MD5 w/ salt
  , user_type_id    BIGINT          NOT NULL REFERENCES users.user_type (user_type_id)
  , active          BOOLEAN         NOT NULL DEFAULT FALSE
);
ALTER TABLE users.user OWNER TO store_db_su;
