DROP TABLE IF EXISTS application.game_type CASCADE;
CREATE TABLE application.game_type (
    game_type_id      BIGSERIAL           PRIMARY KEY
  , name              VARCHAR(255)        NOT NULL
);
ALTER TABLE application.game_type OWNER TO store_db_su;