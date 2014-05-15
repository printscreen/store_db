DROP TABLE IF EXISTS inventory.kickstarter_item CASCADE;
CREATE TABLE inventory.kickstarter_item (
    kickstarter_item_id BIGSERIAL       PRIMARY KEY
  , name                VARCHAR(255)    NOT NULL
  , description         TEXT            NOT NULL
  , is_physical_item    BOOLEAN         NOT NULL
);
ALTER TABLE inventory.kickstarter_item OWNER TO store_db_su;
