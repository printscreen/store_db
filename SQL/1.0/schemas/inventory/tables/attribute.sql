DROP TABLE IF EXISTS inventory.attribute CASCADE;
CREATE TABLE inventory.attribute (
    attribute_id    BIGSERIAL       PRIMARY KEY
  , name            VARCHAR(128)    NOT NULL
  , parent_id       BIGINT          NULL REFERENCES inventory.attribute (attribute_id) ON DELETE CASCADE
);
ALTER TABLE inventory.attribute OWNER TO store_db_su;
ALTER TABLE inventory.attribute ADD CONSTRAINT c_inventory_attribute_name_parent_id UNIQUE (name,parent_id);