DROP TYPE IF EXISTS transaction.t_carrier CASCADE;
CREATE TYPE transaction.t_carrier AS (
    carrier_id      BIGINT
  , carrier_name    VARCHAR(128)
  , total           BIGINT
);
ALTER TYPE transaction.t_carrier OWNER TO store_db_su;
