DROP TYPE IF EXISTS transaction.t_user_digital_item CASCADE;
CREATE TYPE transaction.t_user_digital_item AS (
    item_id                 BIGINT
  , user_id                 BIGINT
  , order_id                BIGINT
  , order_number            BIGINT
  , sale_item_id            BIGINT
  , name                    VARCHAR(128)
  , active                  BOOLEAN
  , description             TEXT
  , file_path               VARCHAR(255)
  , file_path_orgin_id      BIGINT
  , file_path_orgin_name    VARCHAR(128)
  , total                   BIGINT
);
ALTER TYPE transaction.t_user_digital_item  OWNER TO store_db_su;