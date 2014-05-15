DROP FUNCTION IF EXISTS set_user_type (
    i_user_type_id      BIGINT
  , i_user_type_name    VARCHAR(128)
);
CREATE OR REPLACE FUNCTION set_user_type (
    i_user_type_id      BIGINT
  , i_user_type_name    VARCHAR(128)
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old users.user_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM users.user_type WHERE user_type_id = i_user_type_id;
        IF v_old.user_type_id IS NULL THEN
            SELECT * INTO v_old FROM users.user_type WHERE upper(user_type_name) = upper(i_user_type_name);
        END IF;
        
        IF v_old.user_type_id IS NULL THEN
            INSERT INTO users.user_type (
                user_type_name
            ) VALUES (
                upper(trim(i_user_type_name))
            );

            v_id := CURRVAL('users.user_type_user_type_id_seq');
        ELSE
            UPDATE users.user_type SET
                user_type_name = COALESCE(upper(trim(i_user_type_name)), user_type_name)
            WHERE
                user_type_id = v_old.user_type_id;

            v_id := v_old.user_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
