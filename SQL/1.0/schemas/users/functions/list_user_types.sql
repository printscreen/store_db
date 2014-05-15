CREATE OR REPLACE FUNCTION list_user_type ()
RETURNS SETOF users.t_user_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
    BEGIN
        v_sql := '
            SELECT 
                 user_type_id 
                ,user_type_name
            FROM users.v_user_type
            ORDER BY user_type_name;
        ';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            RETURN NEXT REC;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
