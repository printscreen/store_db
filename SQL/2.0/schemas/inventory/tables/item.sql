ALTER TABLE inventory.item ADD COLUMN item_type_id BIGINT NOT NULL REFERENCES inventory.item_type (item_type_id);
ALTER TABLE inventory.item ADD COLUMN quantity BIGINT NOT NULL DEFAULT 0;