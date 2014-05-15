DROP TABLE IF EXISTS application.menu_group CASCADE;
CREATE TABLE application.menu_group (
    menu_group_id   BIGSERIAL           PRIMARY KEY
  , name            VARCHAR(255)        NOT NULL
);
ALTER TABLE application.menu_group OWNER TO store_db_su;
