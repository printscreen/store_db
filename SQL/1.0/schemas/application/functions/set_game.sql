DROP FUNCTION IF EXISTS set_game (
    i_game_id           BIGINT
  , i_name              VARCHAR(255)
  , i_label             VARCHAR(255)
  , i_description       TEXT
  , i_thumbnail         VARCHAR(255)
  , i_buy_link          VARCHAR(255)
);
CREATE OR REPLACE FUNCTION set_game (
    i_game_id           BIGINT
  , i_name              VARCHAR(255)
  , i_label             VARCHAR(255)
  , i_description       TEXT
  , i_thumbnail         VARCHAR(255)
  , i_buy_link          VARCHAR(255)
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.game;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.game WHERE game_id = i_game_id;
        IF v_old.game_id IS NULL THEN
            SELECT * INTO v_old FROM application.game WHERE name = trim(lower(i_name));
        END IF;

        IF v_old.game_id IS NULL THEN
            INSERT INTO application.game (
                name
              , label
              , description
              , thumbnail
              , buy_link
            ) VALUES (
                trim(lower(i_name))
              , i_label
              , i_description
              , i_thumbnail
              , i_buy_link
            );

            v_id := CURRVAL('application.game_game_id_seq');
        ELSE
            UPDATE application.game SET
                name = COALESCE(trim(lower(i_name)), name)
              , label = COALESCE(i_label, label)
              , description = COALESCE(i_description, description)
              , thumbnail = COALESCE(i_thumbnail, thumbnail)
              , buy_link = COALESCE(i_buy_link, buy_link)
            WHERE
                game_id = v_old.game_id;

            v_id := v_old.game_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
