DROP TABLE IF EXISTS transaction.kickstarter_pledge CASCADE;
CREATE TABLE transaction.kickstarter_pledge (
    kickstarter_pledge_id   BIGSERIAL       PRIMARY KEY
  , kickstarter_id          BIGINT          NOT NULL REFERENCES users.kickstarter (kickstarter_id)
  , amount                  BIGINT          NOT NULL
  , transaction_id          TEXT            NOT NULL UNIQUE
  , pledge_source_id        BIGINT          NOT NULL REFERENCES transaction.pledge_source (pledge_source_id)
);
ALTER TABLE transaction.kickstarter_pledge OWNER TO store_db_su;
