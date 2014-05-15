DROP FUNCTION IF EXISTS get_mail (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_mail (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_mail
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail;
    BEGIN
        v_sql := '
            SELECT 
                  m.mail_id         AS mail_id
                , m.name            AS name
                , m.html_mail       AS html_mail
                , m.plaintext_mail  AS plaintext_mail
                , m.insert_ts       AS insert_ts
                , m.first_sent      AS first_sent
                ,( SELECT COUNT(*)
                         FROM application.v_mail m
                       )::BIGINT    AS total
            FROM application.v_mail m
            WHERE TRUE'
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_id        := REC.mail_id;
            v_return.name           := REC.name;
            v_return.html_mail      := REC.html_mail;
            v_return.plaintext_mail := REC.plaintext_mail;
            v_return.insert_ts      := REC.insert_ts;
            v_return.first_sent     := REC.first_sent;
            v_return.total          := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_mail (
    i_mail_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_mail (
    i_mail_id           BIGINT
)
RETURNS SETOF application.t_mail
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail;
    BEGIN
        IF i_mail_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  m.mail_id         AS mail_id
                , m.name            AS name
                , m.html_mail       AS html_mail
                , m.plaintext_mail  AS plaintext_mail
                , m.insert_ts       AS insert_ts
                , m.first_sent      AS first_sent
                , 1                 AS total
            FROM application.v_mail m
            WHERE m.mail_id='||i_mail_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_id        := REC.mail_id;
            v_return.name           := REC.name;
            v_return.html_mail      := REC.html_mail;
            v_return.plaintext_mail := REC.plaintext_mail;
            v_return.insert_ts      := REC.insert_ts;
            v_return.first_sent     := REC.first_sent;
            v_return.total          := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_mail (
    i_mail_name VARCHAR(255)
);
CREATE OR REPLACE FUNCTION get_mail (
    i_mail_name VARCHAR(255)
)
RETURNS SETOF application.t_mail
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_mail;
    BEGIN
        IF i_mail_name IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                  m.mail_id         AS mail_id
                , m.name            AS name
                , m.html_mail       AS html_mail
                , m.plaintext_mail  AS plaintext_mail
                , m.insert_ts       AS insert_ts
                , m.first_sent      AS first_sent
                , 1                 AS total
            FROM application.v_mail m
            WHERE lower(trim(m.name))='|| quote_literal(lower(trim(i_mail_name)))||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.mail_id        := REC.mail_id;
            v_return.name           := REC.name;
            v_return.html_mail      := REC.html_mail;
            v_return.plaintext_mail := REC.plaintext_mail;
            v_return.insert_ts      := REC.insert_ts;
            v_return.first_sent     := REC.first_sent;
            v_return.total          := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
