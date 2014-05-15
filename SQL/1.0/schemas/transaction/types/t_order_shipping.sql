DROP TYPE IF EXISTS transaction.t_order_shipping CASCADE;
CREATE TYPE transaction.t_order_shipping AS (
    order_shipping_id       BIGINT
  , shipping_insert_ts      TIMESTAMPTZ
  , shipping_update_ts      TIMESTAMPTZ
  , shipping_first_name     VARCHAR(128)
  , shipping_last_name      VARCHAR(128)
  , order_id                BIGINT
  , shipping_cost           DOUBLE PRECISION
  , address_id              BIGINT
  , address_insert_ts       TIMESTAMPTZ
  , address_update_ts       TIMESTAMPTZ
  , street                  VARCHAR
  , unit_number             VARCHAR
  , city                    VARCHAR
  , state                   VARCHAR
  , postal_code             VARCHAR
  , country_id              BIGINT
  , country_name            VARCHAR(128)
  , country_code            VARCHAR(4)
  , user_id                 BIGINT
  , user_first_name         VARCHAR(128)
  , user_last_name          VARCHAR(128)
  , active                  BOOLEAN
  , hash                    VARCHAR(255)
);
ALTER TYPE transaction.t_order_shipping OWNER TO store_db_su;
