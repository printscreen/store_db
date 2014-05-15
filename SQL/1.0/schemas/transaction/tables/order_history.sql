DROP TABLE IF EXISTS transaction.order_history CASCADE;
CREATE TABLE transaction.order_history (
      order_history_id      BIGSERIAL       PRIMARY KEY
    , insert_ts             TIMESTAMPTZ     DEFAULT NOW()
    , order_id              BIGINT          NOT NULL
    , user_id               BIGINT          NOT NULL REFERENCES users.user (user_id)
    , description           TEXT            NOT NULL
    , order_history_type_id BIGINT          NOT NULL REFERENCES transaction.order_history_type (order_history_type_id)
);
ALTER TABLE transaction.order_history OWNER TO store_db_su;
