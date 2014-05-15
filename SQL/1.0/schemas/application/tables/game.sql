DROP TABLE IF EXISTS application.game CASCADE;
CREATE TABLE application.game (
    game_id         BIGSERIAL           PRIMARY KEY
  , name            VARCHAR(255)        NOT NULL
  , label           VARCHAR(255)        NOT NULL
  , description     TEXT                NOT NULL
  , thumbnail       VARCHAR(255)        NOT NULL
  , buy_link        VARCHAR(255)        NULL
);
ALTER TABLE application.game OWNER TO store_db_su;
