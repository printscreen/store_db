DROP TABLE IF EXISTS transaction.order_shipping CASCADE;
CREATE TABLE transaction.order_shipping (
      order_shipping_id     BIGSERIAL           PRIMARY KEY
    , insert_ts             TIMESTAMPTZ         DEFAULT NOW()
    , update_ts             TIMESTAMPTZ         DEFAULT NOW()
    , first_name            VARCHAR(128)        NOT NULL
    , last_name             VARCHAR(128)        NOT NULL
    , order_id              BIGINT              NOT NULL REFERENCES transaction.order (order_id)
    , address_id            BIGINT              NOT NULL REFERENCES transaction.address (address_id)
    , shipping_cost         DOUBLE PRECISION    DEFAULT 0.00
);
ALTER TABLE transaction.order_shipping OWNER TO store_db_su;
