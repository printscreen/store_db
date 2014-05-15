DROP FUNCTION IF EXISTS get_user_submenu (
    i_user_id           BIGINT
  , i_menu_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_user_submenu (
    i_user_id           BIGINT
  , i_menu_id           BIGINT
)
RETURNS SETOF users.t_user_type_submenu
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user_type_submenu;
        v_find users.user;
    BEGIN
        
        IF i_user_id IS NULL THEN
           return;
        END IF;
        
        SELECT * INTO v_find FROM users.user WHERE user_id = i_user_id;
        
        IF v_find.user_type_id IS NULL THEN
            return;
        END IF;
                
        v_sql := '
            SELECT 
                 utsm.user_type_submenu_id        AS user_type_submenu_id
                ,utsm.user_type_id                AS user_type_id
                ,utsm.user_type_name              AS user_type_name
                ,utsm.submenu_id                  AS submenu_id
                ,utsm.submenu_name                AS submenu_name
                ,utsm.menu_id                     AS menu_id
                ,utsm.menu_name                   AS menu_name
                ,utsm.url                         AS url
                ,utsm.module                      AS module
                ,utsm.controller                  AS controller
                ,utsm.action                      AS action
            FROM users.v_user_type_submenu utsm
            WHERE utsm.user_type_id='|| v_find.user_type_id || 
            ' AND utsm.menu_id=' || i_menu_id ||';';

        -- RAISE INFO '%', v_sql;
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_type_submenu_id   := REC.user_type_submenu_id;
            v_return.user_type_id           := REC.user_type_id;
            v_return.user_type_name         := REC.user_type_name;
            v_return.submenu_id             := REC.submenu_id;
            v_return.submenu_name           := REC.submenu_name;
            v_return.menu_id                := REC.menu_id;
            v_return.menu_name              := REC.menu_name;
            v_return.url                    := REC.url;
            v_return.module                 := REC.module;
            v_return.controller             := REC.controller;
            v_return.action                 := REC.action;
            
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
