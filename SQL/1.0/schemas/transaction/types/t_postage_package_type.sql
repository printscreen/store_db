DROP TYPE IF EXISTS transaction.t_postage_package_type CASCADE;
CREATE TYPE transaction.t_postage_package_type AS (
    postage_package_type_id     BIGINT
  , postage_package_type_name   VARCHAR(255)
  , total                     BIGINT
);
ALTER TYPE transaction.t_postage_package_type OWNER TO store_db_su;
