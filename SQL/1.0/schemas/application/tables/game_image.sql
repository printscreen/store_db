DROP TABLE IF EXISTS application.game_image CASCADE;
CREATE TABLE application.game_image (
    game_image_id   BIGSERIAL           PRIMARY KEY
  , game_id         BIGINT              NOT NULL REFERENCES application.game (game_id)
  , location        VARCHAR(255)        NOT NULL UNIQUE
);
ALTER TABLE application.game_image OWNER TO store_db_su;