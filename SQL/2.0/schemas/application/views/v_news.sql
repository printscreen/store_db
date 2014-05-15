DROP VIEW IF EXISTS application.v_news;
CREATE OR REPLACE VIEW application.v_news AS
SELECT
    n.news_id AS news_id
  , n.title AS title
  , n.description AS description
  , n.insert_ts AS insert_ts
  , n.update_ts AS update_ts
FROM application.news n;
ALTER VIEW application.v_news OWNER TO store_db_su;