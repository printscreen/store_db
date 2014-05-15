DROP TABLE IF EXISTS application.menu_group_menu CASCADE;
CREATE TABLE application.menu_group_menu (
    menu_group_menu_id  BIGSERIAL       PRIMARY KEY
  , menu_group_id       BIGINT          NOT NULL REFERENCES application.menu_group (menu_group_id)
  , menu_id             BIGINT          NOT NULL REFERENCES application.menu (menu_id)
);
ALTER TABLE application.menu_group_menu OWNER TO store_db_su;