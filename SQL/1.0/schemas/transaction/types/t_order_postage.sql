DROP TYPE IF EXISTS transaction.t_order_postage CASCADE;
CREATE TYPE transaction.t_order_postage AS (
    order_postage_id            BIGINT
  , order_id                    BIGINT
  , insert_ts                   TIMESTAMPTZ
  , file_location               TEXT
  , carrier_id                  BIGINT
  , carrier_name                VARCHAR(128)
  , tracking_number             TEXT
  , stamps_id                   TEXT
  , postage_service_type_id     BIGINT
  , postage_service_type_name   VARCHAR(255)
  , postage_service_type_code   VARCHAR(255)
  , postage_package_type_id     BIGINT
  , postage_package_type_name   VARCHAR(255)
  , ship_date                   TIMESTAMPTZ
  , weight                      BIGINT
  , amount                      BIGINT
);
ALTER TYPE transaction.t_order_postage OWNER TO store_db_su;
