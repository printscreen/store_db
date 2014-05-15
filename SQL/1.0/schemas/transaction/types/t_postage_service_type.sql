DROP TYPE IF EXISTS transaction.t_postage_service_type CASCADE;
CREATE TYPE transaction.t_postage_service_type AS (
    postage_service_type_id     BIGINT
  , postage_service_type_name   VARCHAR(255)
  , code                        VARCHAR(255)
  , carrier_id                  BIGINT
  , carrier_name                VARCHAR(128)
  , total                       BIGINT
);
ALTER TYPE transaction.t_postage_service_type OWNER TO store_db_su;
