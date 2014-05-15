DROP VIEW IF EXISTS application.v_submenu;
CREATE OR REPLACE VIEW application.v_submenu AS
SELECT
     sm.submenu_id AS submenu_id
    ,sm.menu_id AS menu_id
    ,sm.name AS name
    ,sm.url AS url
    ,sm.module AS module
    ,sm.controller AS controller
    ,sm.action AS action
FROM application.submenu sm;
ALTER VIEW application.v_submenu OWNER TO store_db_su;
