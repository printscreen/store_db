DROP TYPE IF EXISTS transaction.t_order_postage_addon CASCADE;
CREATE TYPE transaction.t_order_postage_addon AS (
    order_postage_addon_id      BIGINT
  , order_postage_id            BIGINT
  , order_id                    BIGINT
  , carrier_addon_id            BIGINT
  , carrier_addon_name          VARCHAR(255)
  , carrier_id                  BIGINT
  , carrier_name                VARCHAR(128)
  , total                       BIGINT
);
ALTER TYPE transaction.t_order_postage_addon OWNER TO store_db_su;
