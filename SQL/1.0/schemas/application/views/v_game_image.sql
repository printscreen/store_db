DROP VIEW IF EXISTS application.v_game_image;
CREATE OR REPLACE VIEW application.v_game_image AS
SELECT
      gi.game_image_id AS game_image_id
     ,gi.game_id AS game_id
     ,gi.location AS location
FROM application.game_image gi;
ALTER VIEW application.v_game_image OWNER TO store_db_su;