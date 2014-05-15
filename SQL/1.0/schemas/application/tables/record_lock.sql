DROP TABLE IF EXISTS application.record_lock CASCADE;
CREATE TABLE application.record_lock (
    record_lock_id  BIGSERIAL           PRIMARY KEY
  , table_name      VARCHAR(255)        NOT NULL
  , record_id       BIGINT              NOT NULL
  , session_id      VARCHAR(255)        NOT NULL
  , user_id         BIGINT              NOT NULL
  , insert_ts       TIMESTAMPTZ         DEFAULT NOW()
);
ALTER TABLE application.record_lock OWNER TO store_db_su;
