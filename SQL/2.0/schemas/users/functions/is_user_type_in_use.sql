DROP FUNCTION IF EXISTS is_user_type_in_use (
    i_user_type_id      BIGINT
);
CREATE OR REPLACE FUNCTION is_user_type_in_use (
    i_user_type_id      BIGINT
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_user users.user;
    BEGIN
        SELECT * INTO v_user FROM users.user WHERE user_type_id = i_user_type_id LIMIT 1;
        IF v_user.user_id IS NULL THEN
            RETURN false;
        ELSE
            RETURN true;
        END IF;
    END;
$_$
LANGUAGE PLPGSQL;
