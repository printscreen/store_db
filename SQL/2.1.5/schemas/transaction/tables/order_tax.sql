DROP TABLE IF EXISTS transaction.order_tax CASCADE;
CREATE TABLE transaction.order_tax (
      order_tax_id      BIGSERIAL           PRIMARY KEY
    , order_id          BIGINT              NOT NULL REFERENCES transaction.order(order_id) UNIQUE
    , tax_id            BIGINT              NOT NULL REFERENCES transaction.tax(tax_id)
    , rate              DOUBLE PRECISION    NOT NULL DEFAULT 0.0
    , insert_ts         TIMESTAMPTZ         NOT NULL DEFAULT NOW()
);
ALTER TABLE transaction.order_tax OWNER TO store_db_su;