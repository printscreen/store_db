DROP TABLE IF EXISTS inventory.item_file_path CASCADE;
CREATE TABLE inventory.item_file_path (
    item_file_path_id       BIGSERIAL       PRIMARY KEY
  , file_path               VARCHAR(255)    NOT NULL
  , item_file_path_orgin_id BIGINT          NOT NULL REFERENCES inventory.item_file_path_orgin (item_file_path_orgin_id)
  , item_id                 BIGINT          NOT NULL REFERENCES inventory.item (item_id) UNIQUE

);
ALTER TABLE inventory.item_file_path OWNER TO store_db_su;
