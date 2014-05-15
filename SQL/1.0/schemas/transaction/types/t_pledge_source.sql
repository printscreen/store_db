DROP TYPE IF EXISTS transaction.t_pledge_source CASCADE;
CREATE TYPE transaction.t_pledge_source AS (
    pledge_source_id    BIGINT
  , pledge_source_name  VARCHAR(255)
  , total               BIGINT
);
ALTER TYPE transaction.t_pledge_source OWNER TO store_db_su;
