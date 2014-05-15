DROP TABLE IF EXISTS inventory.item_price CASCADE;
CREATE TABLE inventory.item_price (
    item_price_id   BIGSERIAL           PRIMARY KEY
  , item_id         BIGINT              NOT NULL REFERENCES inventory.item (item_id) UNIQUE
  , update_ts       TIMESTAMPTZ         DEFAULT NOW()
  , price           BIGINT              DEFAULT NULL
);
ALTER TABLE inventory.item_price OWNER TO store_db_su;
