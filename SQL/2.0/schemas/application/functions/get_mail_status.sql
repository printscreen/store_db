DROP FUNCTION IF EXISTS get_mail_status (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_mail_status (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_mail_status
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail_status;
    BEGIN
        v_sql := '
            SELECT 
                  ms.mail_status_id AS mail_status_id
                , ms.name           AS name
                ,( SELECT COUNT(*)
                         FROM application.v_mail_status ms
                       )::BIGINT    AS total
            FROM application.v_mail_status ms
            WHERE TRUE'
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_status_id := REC.mail_status_id;
            v_return.name           := REC.name;
            v_return.total          := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_mail_status (
    i_mail_status_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_mail_status (
    i_mail_status_id           BIGINT
)
RETURNS SETOF application.t_mail_status
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail_status;
    BEGIN
        IF i_mail_status_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  ms.mail_status_id AS mail_status_id
                , ms.name           AS name
                , 1                 AS total
            FROM application.v_mail_status ms
            WHERE ms.mail_status_id='||i_mail_status_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_status_id := REC.mail_status_id;
            v_return.name           := REC.name;
            v_return.total          := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
