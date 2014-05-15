DROP TABLE IF EXISTS application.news CASCADE;
CREATE TABLE application.news (
    news_id         BIGSERIAL           PRIMARY KEY
  , title           VARCHAR(255)        NOT NULL
  , description     TEXT                NOT NULL
  , insert_ts       TIMESTAMPTZ         DEFAULT NOW()
);
ALTER TABLE application.news OWNER TO store_db_su;
