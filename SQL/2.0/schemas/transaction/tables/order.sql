ALTER TABLE transaction.order ADD COLUMN shipping_cost BIGINT NOT NULL DEFAULT 0;
ALTER TABLE transaction.order ADD COLUMN ship_to BIGINT NOT NULL REFERENCES transaction.address(address_id);
ALTER TABLE transaction.order ADD COLUMN bill_to BIGINT NOT NULL REFERENCES transaction.address(address_id);