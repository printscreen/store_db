DROP VIEW IF EXISTS application.v_game;
CREATE OR REPLACE VIEW application.v_game AS
SELECT
      g.game_id AS game_id
     ,g.name AS name
     ,g.label AS label
     ,g.description AS description
     ,g.thumbnail AS thumbnail
     ,g.buy_link AS buy_link
FROM application.game g;
ALTER VIEW application.v_game OWNER TO store_db_su;