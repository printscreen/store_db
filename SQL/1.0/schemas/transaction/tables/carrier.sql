DROP TABLE IF EXISTS transaction.carrier CASCADE;
CREATE TABLE transaction.carrier (
    carrier_id          BIGSERIAL       PRIMARY KEY
  , name                VARCHAR(128)    NOT NULL UNIQUE
);
ALTER TABLE transaction.carrier OWNER TO store_db_su;
