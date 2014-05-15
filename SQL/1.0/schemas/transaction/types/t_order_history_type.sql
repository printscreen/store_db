DROP TYPE IF EXISTS transaction.t_order_history_type CASCADE;
CREATE TYPE transaction.t_order_history_type AS (
    order_history_type_id     BIGINT
  , order_history_type_name   VARCHAR(255)
  , total                     BIGINT
);
ALTER TYPE transaction.t_order_history_type OWNER TO store_db_su;
