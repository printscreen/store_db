DROP VIEW IF EXISTS application.v_menu;
CREATE OR REPLACE VIEW application.v_menu AS
SELECT
     m.menu_id AS menu_id
    ,m.name AS name
    ,m.url AS url
    ,m.module AS module
    ,m.controller AS controller
    ,m.action AS action
FROM application.menu m;
ALTER VIEW application.v_menu OWNER TO store_db_su;
