DROP TYPE IF EXISTS transaction.t_carrier_addon CASCADE;
CREATE TYPE transaction.t_carrier_addon AS (
    carrier_addon_id            BIGINT
  , carrier_addon_name          VARCHAR(255)
  , code                        VARCHAR(255)
  , carrier_id                  BIGINT
  , carrier_name                VARCHAR(128)
  , total                       BIGINT
);
ALTER TYPE transaction.t_carrier_addon OWNER TO store_db_su;
