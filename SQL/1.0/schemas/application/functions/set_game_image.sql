DROP FUNCTION IF EXISTS set_game_image (
    i_game_image_id     BIGINT
  , i_game_id           BIGINT
  , i_location          VARCHAR(255)
);
CREATE OR REPLACE FUNCTION set_game_image (
    i_game_image_id     BIGINT
  , i_game_id           BIGINT
  , i_location          VARCHAR(255)
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.game_image;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.game_image WHERE game_image_id = i_game_image_id;

        IF v_old.game_image_id IS NULL THEN
            INSERT INTO application.game_image (
                game_id
              , location
            ) VALUES (
                i_game_id
              , i_location
            );

            v_id := CURRVAL('application.game_image_game_image_id_seq');
        ELSE
            UPDATE application.game_image SET
                game_id = COALESCE(game_id, i_game_id)
              , location = COALESCE(i_location, location)
            WHERE
                game_id = v_old.game_image_id;

            v_id := v_old.game_image_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;