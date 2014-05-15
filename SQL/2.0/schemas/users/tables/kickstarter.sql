ALTER TABLE users.kickstarter ADD COLUMN user_id BIGINT NULL DEFAULT NULL REFERENCES users.user (user_id);
ALTER TABLE users.kickstarter ADD COLUMN order_id BIGINT NULL DEFAULT NULL REFERENCES transaction.order (order_id);
ALTER TABLE users.kickstarter ADD COLUMN address_id BIGINT NULL DEFAULT NULL REFERENCES transaction.address (address_id);