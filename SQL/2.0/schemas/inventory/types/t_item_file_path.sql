DROP TYPE IF EXISTS inventory.t_item_file_path CASCADE;
CREATE TYPE inventory.t_item_file_path AS (
    item_file_path_id           BIGINT
  , item_id                     BIGINT
  , item_name                   VARCHAR(255)
  , file_path                   VARCHAR(255)
  , item_file_path_orgin_id     BIGINT
  , item_file_path_orgin_name   VARCHAR(32)
  , total                       BIGINT
);
ALTER TYPE inventory.t_item_file_path OWNER TO store_db_su;