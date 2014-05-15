DROP TABLE IF EXISTS transaction.order_billing CASCADE;
CREATE TABLE transaction.order_billing (
      order_billing_id      BIGSERIAL       PRIMARY KEY
    , insert_ts             TIMESTAMPTZ     DEFAULT NOW()
    , update_ts             TIMESTAMPTZ     DEFAULT NULL
    , first_name            VARCHAR(128)    NOT NULL
    , last_name             VARCHAR(128)    NOT NULL
    , authorization_number  VARCHAR(128)    DEFAULT NULL
    , order_id              BIGINT          NOT NULL REFERENCES transaction.order (order_id)
    , address_id            BIGINT          NOT NULL REFERENCES transaction.address (address_id)
);
ALTER TABLE transaction.order_billing OWNER TO store_db_su;
