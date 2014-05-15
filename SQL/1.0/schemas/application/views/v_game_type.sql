DROP VIEW IF EXISTS application.v_game_type;
CREATE OR REPLACE VIEW application.v_game_type AS
SELECT
      gt.game_type_id AS game_type_id
     ,gt.name AS name
FROM application.game_type gt;
ALTER VIEW application.v_game_type OWNER TO store_db_su;