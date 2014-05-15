DROP FUNCTION IF EXISTS set_game_type (
    i_game_type_id      BIGINT
  , i_name              VARCHAR(255)
);
CREATE OR REPLACE FUNCTION set_game_type (
    i_game_type_id      BIGINT
  , i_name              VARCHAR(255)
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.game_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.game_type WHERE game_type_id = i_game_type_id;

        IF v_old.game_type_id IS NULL THEN
            INSERT INTO application.game_type (
                name
            ) VALUES (
                trim(i_name)
            );

            v_id := CURRVAL('application.game_type_game_type_id_seq');
        ELSE
            UPDATE application.game_type SET
                name = COALESCE(trim(i_name), name)
            WHERE
                game_type_id = v_old.game_type_id;

            v_id := v_old.game_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
