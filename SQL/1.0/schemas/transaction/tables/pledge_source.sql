DROP TABLE IF EXISTS transaction.pledge_source CASCADE;
CREATE TABLE transaction.pledge_source (
      pledge_source_id      BIGSERIAL           PRIMARY KEY
    , name                  VARCHAR(255)        NOT NULL UNIQUE
);
ALTER TABLE transaction.pledge_source OWNER TO store_db_su;
