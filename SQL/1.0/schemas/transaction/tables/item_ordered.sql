DROP TABLE IF EXISTS transaction.item_ordered CASCADE;
CREATE TABLE transaction.item_ordered (
      item_ordered_id       BIGSERIAL       PRIMARY KEY
    , insert_ts             TIMESTAMPTZ     DEFAULT NOW()
    , update_ts             TIMESTAMPTZ     DEFAULT NOW()
    , order_id              BIGINT          NOT NULL REFERENCES transaction.order (order_id)
    , item_id               BIGINT          NOT NULL REFERENCES inventory.item (item_id)
    , quantity              BIGINT          NOT NULL
    , active                BOOLEAN         NOT NULL
);
ALTER TABLE transaction.item_ordered OWNER TO store_db_su;
