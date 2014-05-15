ALTER TABLE transaction.address ADD COLUMN first_name VARCHAR(128) NOT NULL;
ALTER TABLE transaction.address ADD COLUMN last_name VARCHAR(128) NOT NULL;
ALTER TABLE transaction.address ADD COLUMN phone_number VARCHAR(100) DEFAULT NULL;