DROP FUNCTION IF EXISTS get_contact (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_contact (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_contact
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_contact;
    BEGIN
        v_sql := '
            SELECT 
                  c.contact_id      AS contact_id
                , c.email           AS email
                , c.first_name      AS first_name
                , c.last_name       AS last_name
                , c.user_id         AS user_id
                , c.active          AS active
                ,( SELECT COUNT(*)
                         FROM application.v_contact c
                       )::BIGINT    AS total
            FROM application.v_contact c
            WHERE TRUE'
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

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

DROP FUNCTION IF EXISTS get_contact (
    i_filter_email      VARCHAR(255)
  , i_filter_first_name VARCHAR(255)
  , i_filter_last_name  VARCHAR(255)
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_contact (
    i_filter_email      VARCHAR(255)
  , i_filter_first_name VARCHAR(255)
  , i_filter_last_name  VARCHAR(255)
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_contact
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_contact;
    BEGIN
        v_sql := '
            SELECT 
                  c.contact_id      AS contact_id
                , c.email           AS email
                , c.first_name      AS first_name
                , c.last_name       AS last_name
                , c.user_id         AS user_id
                , c.active          AS active
                ,( SELECT COUNT(*)
                         FROM application.v_contact c
                         WHERE true '
                         || COALESCE(' AND email ILIKE ' || quote_literal(i_filter_email||'%'),'')
                         || COALESCE(' AND first_name ILIKE ' || quote_literal(i_filter_first_name||'%'),'')
                         || COALESCE(' AND last_name ILIKE ' || quote_literal(i_filter_last_name||'%'),'')
                         ||
                       ')::BIGINT   AS total
            FROM application.v_contact c
            WHERE TRUE '
            || COALESCE(' AND email ILIKE ' || quote_literal(i_filter_email||'%'),'')
            || COALESCE(' AND first_name ILIKE ' || quote_literal(i_filter_first_name||'%'),'')
            || COALESCE(' AND last_name ILIKE ' || quote_literal(i_filter_last_name||'%'),'')
            ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

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


DROP FUNCTION IF EXISTS get_contact (
    i_contact_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_contact (
    i_contact_id           BIGINT
)
RETURNS SETOF application.t_contact
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_contact;
    BEGIN
        IF i_contact_id IS NULL THEN
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
            WHERE c.contact_id='||i_contact_id||';';

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

DROP FUNCTION IF EXISTS get_contact (
    i_email VARCHAR(255)
);
CREATE OR REPLACE FUNCTION get_contact (
    i_email VARCHAR(255)
)
RETURNS SETOF application.t_contact
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_contact;
    BEGIN
        IF i_email IS NULL THEN
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
            WHERE lower(trim(c.email))='|| quote_literal(lower(trim(i_email)))||';';

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