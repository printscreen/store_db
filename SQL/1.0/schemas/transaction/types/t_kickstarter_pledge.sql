DROP TYPE IF EXISTS transaction.t_kickstarter_pledge CASCADE;
CREATE TYPE transaction.t_kickstarter_pledge AS (
    kickstarter_pledge_id   BIGINT
  , kickstarter_id          BIGINT
  , amount                  BIGINT
  , transaction_id          TEXT
  , pledge_source_id        BIGINT
  , pledge_source_name      VARCHAR(255)
  , total                   BIGINT
);
ALTER TYPE transaction.t_kickstarter_pledge OWNER TO store_db_su;
