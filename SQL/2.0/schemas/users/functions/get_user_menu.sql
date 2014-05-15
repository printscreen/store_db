DROP FUNCTION IF EXISTS get_user_menu (
    i_user_type_id  BIGINT
);
CREATE OR REPLACE FUNCTION get_user_menu (
    i_user_type_id  BIGINT
)
RETURNS SETOF users.t_user_type_menu
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user_type_menu;
        v_find users.user_type;
    BEGIN
        
        IF i_user_type_id IS NULL THEN
           return;
        END IF;
        
        SELECT * INTO v_find FROM users.user_type WHERE user_type_id = i_user_type_id;
        
        IF v_find.user_type_id IS NULL THEN
            return;
        END IF;

        v_sql := '
            SELECT 
                 utm.user_type_id                AS user_type_id
                ,utm.menu_name                   AS menu_name
                ,utm.url                         AS url
                ,utm.group_name                  AS group_name
                ,( SELECT COUNT(*)
                         FROM users.v_user_type_menu utm WHERE utm.user_type_id='|| v_find.user_type_id || '
                       )::BIGINT       AS total
            FROM users.v_user_type_menu utm
            WHERE utm.user_type_id='|| v_find.user_type_id || ';';

        -- RAISE INFO '%', v_sql;
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_type_id       := REC.user_type_id;
            v_return.menu_name          := REC.menu_name;
            v_return.url                := REC.url;
            v_return.group_name         := REC.group_name;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
