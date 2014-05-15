DROP TABLE IF EXISTS transaction.order_status CASCADE;
CREATE TABLE transaction.order_status (
      order_status_id   BIGSERIAL       PRIMARY KEY
    , name              VARCHAR(255)    NOT NULL
);
ALTER TABLE transaction.order_status OWNER TO store_db_su;
