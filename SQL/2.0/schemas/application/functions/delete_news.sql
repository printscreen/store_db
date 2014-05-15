DROP FUNCTION IF EXISTS delete_news (
    i_news_id   BIGINT
);
CREATE OR REPLACE FUNCTION delete_news (
    i_news_id   BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.news;
    BEGIN
        SELECT * INTO v_old FROM application.news WHERE news_id = i_news_id;
        IF v_old.news_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM application.news WHERE news_id = i_news_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
