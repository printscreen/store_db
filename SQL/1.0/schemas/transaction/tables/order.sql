DROP TABLE IF EXISTS transaction.order CASCADE;
CREATE TABLE transaction.order (
      order_id          BIGSERIAL       PRIMARY KEY
    , insert_ts         TIMESTAMPTZ     DEFAULT NOW()
    , transaction_id    VARCHAR(255)    NULL
    , order_number      BIGSERIAL       UNIQUE NOT NULL
    , user_id           BIGINT          NOT NULL REFERENCES users.user (user_id)
    , order_status_id   BIGINT          NOT NULL REFERENCES transaction.order_status (order_status_id)
);
ALTER SEQUENCE transaction.order_order_number_seq MINVALUE 8596899 START 8596899 RESTART 8596899;
ALTER TABLE transaction.order OWNER TO store_db_su;
