DROP FUNCTION IF EXISTS delete_user_type (
    i_user_type_id      BIGINT
);
CREATE OR REPLACE FUNCTION delete_user_type (
    i_user_type_id      BIGINT
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old users.user_type;
        v_user users.user;
    BEGIN
	    SELECT * INTO v_old FROM users.user_type WHERE user_type_id = i_user_type_id;
        SELECT * INTO v_user FROM users.user WHERE user_type_id = i_user_type_id LIMIT 1;
        IF v_old.user_type_id IS NOT NULL AND v_user.user_id IS NULL THEN
            DELETE FROM users.user_type WHERE user_type_id = i_user_type_id;
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    END;
$_$
LANGUAGE PLPGSQL;
