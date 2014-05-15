DROP FUNCTION IF EXISTS get_game_image (
    i_game_id           BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_game_image (
    i_game_id           BIGINT 
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_game_image
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_game_image;
    BEGIN
	    IF i_game_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                  gi.game_image_id  AS game_image_id
                , gi.game_id        AS game_id
                , gi.location       AS location
                ,( SELECT COUNT(*)
                         FROM application.v_game_image gi WHERE game_id =' || i_game_id ||
                       ')::BIGINT    AS total
            FROM application.v_game_image gi WHERE game_id =' || i_game_id ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.game_image_id              := REC.game_image_id;
            v_return.game_id                    := REC.game_id;
            v_return.location                   := REC.location;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_game_image (
    i_game_image_id     BIGINT
);
CREATE OR REPLACE FUNCTION get_game_image (
    i_game_image_id     BIGINT 
)
RETURNS SETOF application.t_game_image
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_game_image;
    BEGIN
        IF i_game_image_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  gi.game_image_id  AS game_image_id
                , gi.game_id        AS game_id
                , gi.location       AS location
                , 1                 AS total
            FROM application.v_game_image gi WHERE game_imgae_id =' || i_game_image_id ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.game_image_id              := REC.game_image_id;
            v_return.game_id                    := REC.game_id;
            v_return.location                   := REC.location;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;