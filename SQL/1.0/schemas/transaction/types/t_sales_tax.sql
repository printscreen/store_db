DROP TYPE IF EXISTS transaction.t_sales_tax CASCADE;
CREATE TYPE transaction.t_sales_tax AS (
      sales_tax_id      BIGINT
    , insert_ts         TIMESTAMPTZ
    , update_ts         TIMESTAMPTZ
    , postal_code       VARCHAR(128)
    , city              VARCHAR(128)
    , state             VARCHAR(128)
    , country_id        BIGINT
    , tax_rate          DOUBLE PRECISION
    , total             BIGINT
);
ALTER TYPE transaction.t_sales_tax OWNER TO store_db_su;
