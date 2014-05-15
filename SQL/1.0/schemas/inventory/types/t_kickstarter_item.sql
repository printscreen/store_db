DROP TYPE IF EXISTS inventory.t_kickstarter_item CASCADE;
CREATE TYPE inventory.t_kickstarter_item AS (
    kickstarter_item_id     BIGINT
  , item_name               VARCHAR(255)
  , description             TEXT
  , is_physical_item        BOOLEAN
  , total                   BIGINT
);
ALTER TYPE inventory.t_kickstarter_item OWNER TO store_db_su;