DROP TABLE IF EXISTS application.menu CASCADE;
CREATE TABLE application.menu (
    menu_id         BIGSERIAL           PRIMARY KEY
  , name            VARCHAR(255)        NOT NULL
  , url             VARCHAR(255)        NOT NULL
  , module          VARCHAR(255)        NOT NULL
  , controller      VARCHAR(255)        NOT NULL
  , action          VARCHAR(255)        NOT NULL
);
ALTER TABLE application.menu OWNER TO store_db_su;
