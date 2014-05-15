DROP TABLE IF EXISTS application.game_type_association CASCADE;
CREATE TABLE application.game_type_association (
    game_type_association_id    BIGSERIAL           PRIMARY KEY
  , game_id                     BIGINT              NOT NULL REFERENCES application.game (game_id)
  , game_type_id                BIGINT              NOT NULL REFERENCES application.game_type (game_type_id)
);
ALTER TABLE application.game_type_association OWNER TO store_db_su;