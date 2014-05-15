DROP TABLE IF EXISTS application.contact CASCADE;
CREATE TABLE application.contact (
    contact_id          BIGSERIAL       PRIMARY KEY
  , email               VARCHAR(255)    NOT NULL UNIQUE
  , first_name          VARCHAR(255)    NULL
  , last_name           VARCHAR(255)    NULL
  , user_id             BIGINT          NULL REFERENCES users.user (user_id) UNIQUE
  , active              BOOLEAN         DEFAULT true
);
ALTER TABLE application.contact OWNER TO store_db_su;
