DROP TABLE IF EXISTS transaction.carrier_addon CASCADE;
CREATE TABLE transaction.carrier_addon (
      carrier_addon_id          BIGSERIAL       PRIMARY KEY
    , carrier_id                BIGINT          NOT NULL REFERENCES transaction.carrier (carrier_id)
    , name                      VARCHAR(255)    NOT NULL
    , code                      VARCHAR(255)    NULL
);
ALTER TABLE transaction.carrier_addon OWNER TO store_db_su;
