DROP TYPE IF EXISTS transaction.t_order_status CASCADE;
CREATE TYPE transaction.t_order_status AS (
    order_stauts_id     BIGINT
  , order_status_name   VARCHAR(255)
);
ALTER TYPE transaction.t_order_status OWNER TO store_db_su;
