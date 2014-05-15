DROP FUNCTION IF EXISTS get_contact_by_user_id (
    i_user_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_contact_by_user_id (
    i_user_id           BIGINT
)
RETURNS SETOF application.t_contact
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_contact;
    BEGIN
        IF i_user_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  c.contact_id      AS contact_id
                , c.email           AS email
                , c.first_name      AS first_name
                , c.last_name       AS last_name
                , c.user_id         AS user_id
                , c.active          AS active
                , 1                 AS total
            FROM application.v_contact c
            WHERE c.user_id='||i_user_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.contact_id     := REC.contact_id;
            v_return.email          := REC.email;
            v_return.first_name     := REC.first_name;
            v_return.last_name      := REC.last_name;
            v_return.user_id        := REC.user_id;
            v_return.active         := REC.active;
            v_return.total          := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;