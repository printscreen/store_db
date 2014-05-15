DROP TABLE IF EXISTS transaction.order_postage CASCADE;
CREATE TABLE transaction.order_postage  (
      order_postage_id          BIGSERIAL       PRIMARY KEY
    , order_id                  BIGINT          NOT NULL REFERENCES transaction.order (order_id)
    , insert_ts                 TIMESTAMPTZ     DEFAULT NOW()
    , file_location             TEXT            NOT NULL
    , carrier_id                BIGINT          NOT NULL REFERENCES transaction.carrier (carrier_id)
    , tracking_number           TEXT            NULL
    , stamps_id                 TEXT            NULL
    , postage_service_type_id   BIGINT          NOT NULL REFERENCES transaction.postage_service_type (postage_service_type_id)
    , postage_package_type_id   BIGINT          NOT NULL REFERENCES transaction.postage_package_type (postage_package_type_id)
    , ship_date                 TIMESTAMPTZ     NULL
    , weight                    BIGINT          NOT NULL
    , amount                    BIGINT          NULL
);
ALTER TABLE transaction.order_postage  OWNER TO store_db_su;
