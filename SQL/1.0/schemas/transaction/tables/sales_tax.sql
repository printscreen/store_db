DROP TABLE IF EXISTS transaction.sales_tax CASCADE;
CREATE TABLE transaction.sales_tax (
      sales_tax_id          BIGSERIAL           PRIMARY KEY
    , insert_ts             TIMESTAMPTZ         DEFAULT NOW()
    , update_ts             TIMESTAMPTZ         DEFAULT NOW()
    , postal_code           VARCHAR(128)        NULL
    , city                  VARCHAR(128)        NULL
    , state                 VARCHAR(128)        NULL
    , country_id            BIGINT              NOT NULL REFERENCES transaction.country (country_id)
    , tax_rate              DOUBLE PRECISION    DEFAULT NULL
);
ALTER TABLE transaction.sales_tax OWNER TO store_db_su;
