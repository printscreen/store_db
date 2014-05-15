DROP TABLE IF EXISTS transaction.order_history_type CASCADE;
CREATE TABLE transaction.order_history_type (
      order_history_type_id     BIGSERIAL       PRIMARY KEY
    , name                      VARCHAR(255)    NOT NULL
);
ALTER TABLE transaction.order_history_type OWNER TO store_db_su;
