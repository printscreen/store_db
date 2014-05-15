DROP TYPE IF EXISTS inventory.t_sale_group_picture CASCADE;
CREATE TYPE inventory.t_sale_group_picture AS (
    sale_group_picture_id   BIGINT
  , sale_group_id           BIGINT
  , file_path               VARCHAR(255)
  , thumbnail_path          VARCHAR(255)
  , alt_text                VARCHAR(255)
  , primary_picture         BOOLEAN
  , total                   BIGINT
);
ALTER TYPE inventory.t_sale_group_picture OWNER TO store_db_su;