DROP TYPE IF EXISTS inventory.t_item_file_path_orgin CASCADE;
CREATE TYPE inventory.t_item_file_path_orgin AS (
    item_file_path_orgin_id     BIGINT
  , item_file_path_orgin_name   VARCHAR(32)
  , total                       BIGINT
);
ALTER TYPE inventory.t_item_file_path_orgin OWNER TO store_db_su;