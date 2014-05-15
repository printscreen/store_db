DROP TABLE IF EXISTS application.resource_group_menu CASCADE;
CREATE TABLE application.resource_group_menu (
    resource_group_menu_id      BIGSERIAL       PRIMARY KEY
  , resource_group_id           BIGINT          NOT NULL REFERENCES application.resource_group (resource_group_id)
  , menu_id                     BIGINT          NOT NULL REFERENCES application.menu (menu_id)
);
ALTER TABLE application.resource_group_menu OWNER TO store_db_su;