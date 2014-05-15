DROP TYPE IF EXISTS transaction.t_paypal CASCADE;
CREATE TYPE transaction.t_paypal AS (
    paypal_id           BIGINT
  , insert_ts           TIMESTAMPTZ
  , user_id             BIGINT
  , email               VARCHAR(255)
  , order_status_id     BIGINT
  , order_status_name   VARCHAR(255)
  , shipping_cost       BIGINT
  , ship_to             BIGINT
  , bill_to             BIGINT
  , token               VARCHAR(255)
  , cart                TEXT
  , total               BIGINT
);
ALTER TYPE transaction.t_paypal OWNER TO store_db_su;
