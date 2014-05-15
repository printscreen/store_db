DROP VIEW IF EXISTS users.v_user_type_menu;
CREATE OR REPLACE VIEW users.v_user_type_menu AS
SELECT DISTINCT
    m.name AS menu_name,
    m.url AS url,
    mg.name AS group_name,
    utr.user_type_id AS user_type_id
FROM users.user_type_resource utr
INNER JOIN application.resource_group_resource rgr on rgr.resource_id = utr.resource_id
INNER JOIN application.resource_group_menu rgm ON rgr.resource_group_id = rgm.resource_group_id
INNER JOIN application.menu m ON rgm.menu_id = m.menu_id
INNER JOIN application.menu_group_menu mgm ON mgm.menu_id = m.menu_id
INNER JOIN application.menu_group mg ON mg.menu_group_id = mgm.menu_group_id;
ALTER VIEW users.v_user_type_menu OWNER TO store_db_su;
