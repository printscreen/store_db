DROP FUNCTION IF EXISTS set_news (
    i_news_id           BIGINT
  , i_title             VARCHAR(255)
  , i_description       TEXT
);
CREATE OR REPLACE FUNCTION set_news (
    i_news_id           BIGINT
  , i_title             VARCHAR(255)
  , i_description       TEXT
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.news;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.news WHERE news_id = i_news_id;

        IF v_old.news_id IS NULL THEN
            INSERT INTO application.news (
                title
              , description
            ) VALUES (
                i_title
              , i_description
            );

            v_id := CURRVAL('application.news_news_id_seq');
        ELSE
            UPDATE application.news SET
                title = COALESCE(i_title, title)
              , description = COALESCE(i_description, description)
            WHERE
                news_id = v_old.news_id;

            v_id := v_old.news_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
