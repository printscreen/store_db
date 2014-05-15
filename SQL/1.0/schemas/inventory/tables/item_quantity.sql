DROP TABLE IF EXISTS inventory.item_quantity CASCADE;
CREATE TABLE inventory.item_quantity (
    item_quantity_id    BIGSERIAL  PRIMARY KEY
  , item_id             BIGINT     NOT NULL REFERENCES inventory.item (item_id) UNIQUE
  , quantity            BIGINT     DEFAULT 0
);
ALTER TABLE inventory.item_quantity OWNER TO store_db_su;
