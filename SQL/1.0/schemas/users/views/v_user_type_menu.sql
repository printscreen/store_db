DROP VIEW IF EXISTS users.v_user_type_menu;
CREATE OR REPLACE VIEW users.v_user_type_menu AS
SELECT
     utm.user_type_menu_id AS user_type_menu_id
    ,utm.menu_id AS menu_id
    ,m.name AS menu_name
    ,m.url AS url
    ,m.module AS module
    ,m.controller AS controller
    ,m.action AS action
    ,utm.user_type_id AS user_type_id
    ,ut.user_type_name AS user_type_name
FROM users.user_type_menu utm
    INNER JOIN users.user_type ut ON ut.user_type_id = utm.user_type_id
    INNER JOIN application.menu m ON m.menu_id = utm.menu_id
WHERE
    ut.user_type_id = utm.user_type_id
AND
    m.menu_id = utm.menu_id;
ALTER VIEW users.v_user_type_menu OWNER TO store_db_su;
