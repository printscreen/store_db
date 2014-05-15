DROP TYPE IF EXISTS transaction.t_order_history CASCADE;
CREATE TYPE transaction.t_order_history AS (
    order_history_id        BIGINT
  , order_id                BIGINT
  , insert_ts               TIMESTAMPTZ
  , user_id                 BIGINT
  , first_name              VARCHAR(128)
  , last_name               VARCHAR(128)
  , description             TEXT
  , order_history_type_id   BIGINT
  , order_history_type_name VARCHAR(255)
  , total                   BIGINT
);
ALTER TYPE transaction.t_order_history OWNER TO store_db_su;
