DROP TABLE IF EXISTS inventory.sale_item_item CASCADE;
CREATE TABLE inventory.sale_item_item (
    sale_item_item_id   BIGSERIAL       PRIMARY KEY
  , sale_item_id        BIGINT          NOT NULL REFERENCES inventory.sale_item (sale_item_id)
  , item_id             BIGINT          NOT NULL REFERENCES inventory.item (item_id)
  , quantity            BIGINT          NOT NULL
);
ALTER TABLE inventory.sale_item_item OWNER TO store_db_su;
CREATE INDEX i_sale_items_sale_item_id ON inventory.sale_item_item (sale_item_id);
CREATE UNIQUE INDEX uc_sale_item_id_item_id ON inventory.sale_item_item (sale_item_id,item_id);