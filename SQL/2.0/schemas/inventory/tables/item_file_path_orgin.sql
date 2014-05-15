DROP TABLE IF EXISTS inventory.item_file_path_orgin CASCADE;
CREATE TABLE inventory.item_file_path_orgin (
    item_file_path_orgin_id     BIGSERIAL       PRIMARY KEY
  , name                        VARCHAR(128)    NOT NULL
);
ALTER TABLE inventory.item_file_path_orgin OWNER TO store_db_su;
