DROP VIEW IF EXISTS users.v_user_type_submenu;
CREATE OR REPLACE VIEW users.v_user_type_submenu AS
SELECT
     utsm.user_type_submenu_id AS user_type_submenu_id
    ,utsm.submenu_id AS submenu_id
    ,sm.name AS submenu_name
    ,sm.menu_id AS menu_id
    ,m.name AS menu_name
    ,sm.url AS url
    ,sm.module AS module
    ,sm.controller AS controller
    ,sm.action AS action
    ,utsm.user_type_id AS user_type_id
    ,ut.user_type_name AS user_type_name
FROM users.user_type_submenu utsm
    INNER JOIN users.user_type ut ON ut.user_type_id = utsm.user_type_id
    INNER JOIN application.submenu sm ON sm.submenu_id = utsm.submenu_id
    INNER JOIN application.menu m ON m.menu_id = sm.menu_id
WHERE
    ut.user_type_id = utsm.user_type_id
AND
    sm.submenu_id = utsm.submenu_id
AND
    sm.menu_id = m.menu_id;
ALTER VIEW users.v_user_type_submenu OWNER TO store_db_su;
