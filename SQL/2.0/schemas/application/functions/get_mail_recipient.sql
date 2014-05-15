DROP FUNCTION IF EXISTS get_mail_recipient (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_mail_recipient (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_mail_recipient
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail_recipient;
    BEGIN	    
        v_sql := '
            SELECT 
                 mr.mail_recipient_id   AS mail_recipient_id
                ,mr.mail_id             AS mail_id
                ,mr.contact_id          AS contact_id
                ,mr.email               AS email
                ,mr.first_name          AS first_name
                ,mr.last_name           AS last_name
                ,mr.user_id             AS user_id
                ,mr.mail_status_id      AS mail_status_id
                ,mr.mail_status_name    AS mail_status_name
                ,mr.send_on             AS send_on
                ,( SELECT COUNT(*)
                         FROM application.v_mail_recipient mr
                       )::BIGINT            AS total
            FROM application.v_mail_recipient mr
            WHERE TRUE
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_recipient_id  := REC.mail_recipient_id;
            v_return.mail_id            := REC.mail_id;
            v_return.contact_id         := REC.contact_id;
            v_return.first_name         := REC.first_name;
            v_return.last_name          := REC.last_name;
            v_return.email              := REC.email;
            v_return.user_id            := REC.user_id;
            v_return.mail_status_id     := REC.mail_status_id;
            v_return.mail_status_name   := REC.mail_status_name;
            v_return.send_on            := REC.send_on;
            v_return.total              := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_mail_recipient (
    i_mail_id           BIGINT
  , i_mail_status_id    BIGINT
  , i_filter_email      CHARACTER VARYING
  , i_filter_first_name CHARACTER VARYING
  , i_filter_last_name  CHARACTER VARYING
  , i_start_date        TIMESTAMPTZ
  , i_end_date          TIMESTAMPTZ
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_mail_recipient (
    i_mail_id           BIGINT
  , i_mail_status_id    BIGINT
  , i_filter_email      CHARACTER VARYING
  , i_filter_first_name CHARACTER VARYING
  , i_filter_last_name  CHARACTER VARYING
  , i_start_date        TIMESTAMPTZ
  , i_end_date          TIMESTAMPTZ
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_mail_recipient
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail_recipient;
    BEGIN
        v_sql := '
            SELECT 
                 mr.mail_recipient_id   AS mail_recipient_id
                ,mr.mail_id             AS mail_id
                ,mr.contact_id          AS contact_id
                ,mr.email               AS email
                ,mr.first_name          AS first_name
                ,mr.last_name           AS last_name
                ,mr.user_id             AS user_id
                ,mr.mail_status_id      AS mail_status_id
                ,mr.mail_status_name    AS mail_status_name
                ,mr.send_on             AS send_on
                ,( SELECT COUNT(*)
                         FROM application.v_mail_recipient mr
                         WHERE true '
                         || COALESCE(' AND mail_id = ' || i_mail_id,'')
                         || COALESCE(' AND mail_status_id = ' || i_mail_status_id, '')
                         || COALESCE(' AND email ILIKE ' || quote_literal(i_filter_email||'%'),'')
                         || COALESCE(' AND first_name ILIKE ' || quote_literal(i_filter_first_name||'%'),'')
                         || COALESCE(' AND last_name ILIKE ' || quote_literal(i_filter_last_name||'%'),'')
                         || COALESCE(' AND send_on BETWEEN ' || quote_literal(i_start_date) || '::DATE AND ' || quote_literal(i_end_date) || '::DATE ' ,'')
                         ||
                       ')::BIGINT           AS total
            FROM application.v_mail_recipient mr
            WHERE TRUE '
            || COALESCE(' AND mail_id = ' || i_mail_id,'')
            || COALESCE(' AND mail_status_id = ' || i_mail_status_id, '')
            || COALESCE(' AND email ILIKE ' || quote_literal(i_filter_email||'%'),'')
            || COALESCE(' AND first_name ILIKE ' || quote_literal(i_filter_first_name||'%'),'')
            || COALESCE(' AND last_name ILIKE ' || quote_literal(i_filter_last_name||'%'),'')
            || COALESCE(' AND send_on BETWEEN ' || quote_literal(i_start_date) || '::DATE AND ' || quote_literal(i_end_date) || '::DATE ' ,'')
            ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_recipient_id  := REC.mail_recipient_id;
            v_return.mail_id            := REC.mail_id;
            v_return.contact_id         := REC.contact_id;
            v_return.first_name         := REC.first_name;
            v_return.last_name          := REC.last_name;
            v_return.email              := REC.email;
            v_return.user_id            := REC.user_id;
            v_return.mail_status_id     := REC.mail_status_id;
            v_return.mail_status_name   := REC.mail_status_name;
            v_return.send_on            := REC.send_on;
            v_return.total              := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_mail_recipient (
    i_mail_recipient_id BIGINT
);
CREATE OR REPLACE FUNCTION get_mail_recipient (
    i_mail_recipient_id BIGINT
)
RETURNS SETOF application.t_mail_recipient
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail_recipient;
    BEGIN
        IF i_mail_recipient_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 mr.mail_recipient_id   AS mail_recipient_id
                ,mr.mail_id             AS mail_id
                ,mr.contact_id          AS contact_id
                ,mr.email               AS email
                ,mr.first_name          AS first_name
                ,mr.last_name           AS last_name
                ,mr.user_id             AS user_id
                ,mr.mail_status_id      AS mail_status_id
                ,mr.mail_status_name    AS mail_status_name
                ,mr.send_on             AS send_on
                ,1                      AS total
            FROM application.mail_recipient
            WHERE mr.mail_recipient_id='||i_mail_recipient_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_recipient_id  := REC.mail_recipient_id;
            v_return.mail_id            := REC.mail_id;
            v_return.contact_id         := REC.contact_id;
            v_return.first_name         := REC.first_name;
            v_return.last_name          := REC.last_name;
            v_return.email              := REC.email;
            v_return.user_id            := REC.user_id;
            v_return.mail_status_id     := REC.mail_status_id;
            v_return.mail_status_name   := REC.mail_status_name;
            v_return.send_on            := REC.send_on;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;