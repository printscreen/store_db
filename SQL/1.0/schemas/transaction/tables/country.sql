DROP TABLE IF EXISTS transaction.country CASCADE;
CREATE TABLE transaction.country (
    country_id          BIGSERIAL       PRIMARY KEY
  , name                VARCHAR(128)    NOT NULL
  , code                VARCHAR(4)      NOT NULL
  , active              BOOLEAN         DEFAULT TRUE
);
ALTER TABLE transaction.country OWNER TO store_db_su;
