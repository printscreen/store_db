DROP TABLE IF EXISTS transaction.paypal CASCADE;
CREATE TABLE transaction.paypal (
      paypal_id         BIGSERIAL       PRIMARY KEY
    , insert_ts         TIMESTAMPTZ     DEFAULT NOW()
    , user_id           BIGINT          NOT NULL REFERENCES users.user (user_id)
    , order_status_id   BIGINT          NOT NULL REFERENCES transaction.order_status (order_status_id)
    , shipping_cost     BIGINT          NOT NULL DEFAULT 0
    , ship_to           BIGINT          NOT NULL REFERENCES transaction.address(address_id)
    , bill_to           BIGINT          NOT NULL REFERENCES transaction.address(address_id)
    , token             VARCHAR(255)    NOT NULL UNIQUE
    , cart              TEXT            NOT NULL
);
ALTER TABLE transaction.paypal OWNER TO store_db_su;