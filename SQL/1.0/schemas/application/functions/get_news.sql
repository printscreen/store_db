DROP FUNCTION IF EXISTS get_news (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_news (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_news
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_news;
    BEGIN
        v_sql := '
            SELECT 
                  n.news_id          AS news_id
                , n.title           AS title
                , n.description     AS description
                , n.insert_ts       AS insert_ts
                ,( SELECT COUNT(*)
                         FROM application.v_news n
                       )::BIGINT    AS total
            FROM application.v_news n
            WHERE TRUE'
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.news_id                    := REC.news_id;
            v_return.title                      := REC.title;
            v_return.description                := REC.description;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_news (
    i_news_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_news (
    i_news_id           BIGINT
)
RETURNS SETOF application.t_news
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_news;
    BEGIN
        IF i_news_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  n.news_id         AS news_id
                , n.title           AS title
                , n.description     AS description
                , n.insert_ts       AS insert_ts
                , 1                 AS total
            FROM application.v_news n
            WHERE n.news_id='||i_news_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.news_id                    := REC.news_id;
            v_return.title                      := REC.title;
            v_return.description                := REC.description;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
