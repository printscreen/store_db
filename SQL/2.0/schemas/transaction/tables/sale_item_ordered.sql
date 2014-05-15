DROP TABLE IF EXISTS transaction.item_ordered CASCADE;
DROP TABLE IF EXISTS transaction.sale_item_ordered CASCADE;
CREATE TABLE transaction.sale_item_ordered (
      sale_item_ordered_id  BIGSERIAL       PRIMARY KEY
    , insert_ts             TIMESTAMPTZ     DEFAULT NOW()
    , update_ts             TIMESTAMPTZ     DEFAULT NOW()
    , order_id              BIGINT          NOT NULL REFERENCES transaction.order (order_id)
    , sale_item_id          BIGINT          NOT NULL REFERENCES inventory.sale_item (sale_item_id)
    , price_paid            BIGINT          NOT NULL
    , quantity              BIGINT          NOT NULL
    , active                BOOLEAN         NOT NULL
);
ALTER TABLE transaction.sale_item_ordered OWNER TO store_db_su;
