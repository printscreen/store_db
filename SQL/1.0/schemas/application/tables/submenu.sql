DROP TABLE IF EXISTS application.submenu CASCADE;
CREATE TABLE application.submenu (
    submenu_id      BIGSERIAL           PRIMARY KEY
  , menu_id         BIGINT              NOT NULL REFERENCES application.menu (menu_id)
  , name            VARCHAR(255)        NOT NULL
  , url             VARCHAR(255)        NOT NULL
  , module          VARCHAR(255)        NOT NULL
  , controller      VARCHAR(255)        NOT NULL
  , action          VARCHAR(255)        NOT NULL
);
ALTER TABLE application.submenu OWNER TO store_db_su;
