DROP TABLE IF EXISTS inventory.item_type CASCADE;
CREATE TABLE inventory.item_type (
    item_type_id    BIGSERIAL       PRIMARY KEY
  , name            VARCHAR(128)    NOT NULL
);
ALTER TABLE inventory.item_type OWNER TO store_db_su;
