DROP TABLE IF EXISTS transaction.postage_service_type CASCADE;
CREATE TABLE transaction.postage_service_type (
      postage_service_type_id   BIGSERIAL       PRIMARY KEY
    , carrier_id                BIGINT          NOT NULL REFERENCES transaction.carrier (carrier_id)
    , code                      VARCHAR(255)    NULL
    , name                      VARCHAR(255)    NOT NULL
);
ALTER TABLE transaction.postage_service_type OWNER TO store_db_su;
