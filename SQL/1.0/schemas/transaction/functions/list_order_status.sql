CREATE OR REPLACE FUNCTION list_order_status ()
RETURNS SETOF transaction.t_order_status
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
    BEGIN
        v_sql := '
            SELECT 
                 os.order_status_id AS order_status_id
                ,os.order_status_name AS order_status_name
            FROM transaction.v_order_status os
            ORDER BY order_status_name;
        ';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            RETURN NEXT REC;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
