DROP TABLE IF EXISTS inventory.sale_group_picture CASCADE;
CREATE TABLE inventory.sale_group_picture (
    sale_group_picture_id   BIGSERIAL       PRIMARY KEY
  , sale_group_id           BIGINT          NOT NULL REFERENCES inventory.sale_group(sale_group_id)
  , file_path               VARCHAR(255)    NOT NULL
  , thumbnail_path          VARCHAR(255)    NOT NULL
  , alt_text                VARCHAR(255)    NULL
  , primary_picture         BOOLEAN         DEFAULT false
);
ALTER TABLE inventory.sale_group_picture OWNER TO store_db_su;
