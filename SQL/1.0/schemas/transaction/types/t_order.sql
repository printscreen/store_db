DROP TYPE IF EXISTS transaction.t_order CASCADE;
CREATE TYPE transaction.t_order AS (
    order_id            BIGINT
  , insert_ts           TIMESTAMPTZ
  , transaction_id      VARCHAR(255)
  , order_number        BIGINT
  , user_id             BIGINT
  , order_status_id     BIGINT
  , order_status_name   VARCHAR(255)
  , total               BIGINT
);
ALTER TYPE transaction.t_order OWNER TO store_db_su;
