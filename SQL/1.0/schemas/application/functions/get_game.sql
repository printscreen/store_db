DROP FUNCTION IF EXISTS get_game (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_game (
    i_sort_field        BIGINT
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
        v_sql := '
            SELECT 
                  g.game_id         AS game_id
                , g.name            AS name
                , g.label           AS label
                , g.description     AS description
                , g.thumbnail       AS thumbnail
                , g.buy_link        AS buy_link
                ,( SELECT COUNT(*)
                         FROM application.v_game g
                       )::BIGINT    AS total
            FROM application.v_game g
            WHERE TRUE'
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

DROP FUNCTION IF EXISTS get_game (
    i_game_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_game (
    i_game_id           BIGINT
)
RETURNS SETOF application.t_game
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_game;
    BEGIN
        IF i_game_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  g.game_id         AS game_id
                , g.name            AS name
                , g.label           AS label
                , g.description     AS description
                , g.thumbnail       AS thumbnail
                , g.buy_link        AS buy_link
                , 1                 AS total
            FROM application.v_game g
            WHERE g.game_id='||i_game_id||';';

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
