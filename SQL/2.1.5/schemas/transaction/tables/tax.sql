DROP TABLE IF EXISTS transaction.tax CASCADE;
CREATE TABLE transaction.tax (
      tax_id            BIGSERIAL           PRIMARY KEY
    , postal_code       BIGINT              NOT NULL UNIQUE
    , rate              DOUBLE PRECISION    NOT NULL DEFAULT 0.0
    , active            BOOLEAN             DEFAULT false
    , update_ts         TIMESTAMPTZ         DEFAULT NOW()
    , insert_ts         TIMESTAMPTZ         DEFAULT NOW()
);
ALTER TABLE transaction.tax OWNER TO store_db_su;