DROP FUNCTION IF EXISTS get_game_by_game_type (
    i_game_type_id      BIGINT  
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_game_by_game_type (
    i_game_type_id      BIGINT  
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_game
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_game;
    BEGIN
        IF i_game_type_id IS NULL THEN
            RETURN;
        END IF;
	    
	    v_sql := '
            SELECT 
                  gt.game_id         AS game_id
                , gt.name            AS name
                , gt.label           AS label
                , gt.description     AS description
                , gt.thumbnail       AS thumbnail
                , gt.buy_link        AS buy_link
                ,( SELECT COUNT(*)
                         FROM application.v_game_by_type gt
                       )::BIGINT    AS total
            FROM application.v_game_by_type gt
            WHERE gt.game_type_id = ' || i_game_type_id ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.game_id                    := REC.game_id;
            v_return.name                       := REC.name;
            v_return.label                      := REC.label;
            v_return.description                := REC.description;
            v_return.thumbnail                  := REC.thumbnail;
            v_return.buy_link                   := REC.buy_link;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;