DROP TABLE IF EXISTS transaction.sale_key CASCADE;
CREATE TABLE transaction.sale_key (
      sale_key_id           BIGSERIAL       PRIMARY KEY
    , key                   TEXT            NOT NULL
    , order_id              BIGINT          NOT NULL REFERENCES transaction.order (order_id)
    , sale_item_id          BIGINT          NOT NULL REFERENCES inventory.sale_item (sale_item_id)
    , item_id               BIGINT          NOT NULL REFERENCES inventory.item (item_id)
);
ALTER TABLE transaction.sale_key OWNER TO store_db_su;
