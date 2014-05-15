ALTER TABLE users.user ADD COLUMN stripe_id VARCHAR(32) NULL DEFAULT NULL;
ALTER TABLE users.user ADD COLUMN verified BOOLEAN NOT NULL DEFAULT false;
UPDATE users.user SET verified = true;