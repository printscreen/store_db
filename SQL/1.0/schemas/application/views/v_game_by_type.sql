DROP VIEW IF EXISTS application.v_game_by_type;
CREATE OR REPLACE VIEW application.v_game_by_type AS
SELECT
      g.game_id AS game_id
     ,g.name AS name
     ,g.label AS label
     ,g.description AS description
     ,g.thumbnail AS thumbnail
     ,g.buy_link AS buy_link
     ,gta.game_type_id AS game_type_id
FROM application.game_type_association gta
INNER JOIN application.game g ON gta.game_id = g.game_id;
ALTER VIEW application.v_game_by_type OWNER TO store_db_su;