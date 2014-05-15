DROP TABLE IF EXISTS inventory.item_attribute CASCADE;
CREATE TABLE inventory.item_attribute (
    item_attribute_id   BIGSERIAL  PRIMARY KEY
  , item_id             BIGINT     NOT NULL REFERENCES inventory.item (item_id) ON DELETE CASCADE
  , attribute_id        BIGINT     NOT NULL REFERENCES inventory.attribute (attribute_id) ON DELETE CASCADE
);
ALTER TABLE inventory.item_attribute OWNER TO store_db_su;
ALTER TABLE inventory.item_attribute ADD CONSTRAINT c_inventory_item_attribute_item UNIQUE (item_id,attribute_id);
