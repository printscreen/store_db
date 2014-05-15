DROP TYPE IF EXISTS application.t_news CASCADE;
CREATE TYPE application.t_news AS (
	news_id BIGINT
  , title VARCHAR(255)
  , description TEXT
  , insert_ts TIMESTAMPTZ
  , update_ts TIMESTAMPTZ
  , total BIGINT
);
ALTER TYPE application.t_news OWNER TO store_db_su;