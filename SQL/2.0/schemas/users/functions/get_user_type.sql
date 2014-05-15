DROP FUNCTION IF EXISTS get_user_type (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_user_type (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF users.t_user_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user_type;
    BEGIN

        v_sql := '
            SELECT 
                 ut.user_type_id         AS user_type_id
                ,ut.user_type_name       AS user_type_name
                ,( SELECT COUNT(*)
                         FROM users.v_user_type ut
                       )::BIGINT       AS total
            FROM users.v_user_type ut
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_type_id               := REC.user_type_id;
            v_return.user_type_name             := REC.user_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_user_type (
    i_user_type_id  BIGINT
);
CREATE OR REPLACE FUNCTION get_user_type (
    i_user_type_id  BIGINT
)
RETURNS SETOF users.t_user_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user_type;
    BEGIN
	    IF i_user_type_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 ut.user_type_id        AS user_type_id
                ,ut.user_type_name      AS user_type_name
                ,1                      AS total
            FROM users.v_user_type ut
            WHERE ut.user_type_id='||i_user_type_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_type_id               := REC.user_type_id;
            v_return.user_type_name             := REC.user_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_user_type (
    i_user_type_name  CHARACTER VARYING
);
CREATE OR REPLACE FUNCTION get_user_type (
    i_user_type_name  CHARACTER VARYING
)
RETURNS SETOF users.t_user_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user_type;
    BEGIN
        IF i_user_type_name IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 ut.user_type_id        AS user_type_id
                ,ut.user_type_name      AS user_type_name
                ,1                      AS total
            FROM users.v_user_type ut
            WHERE ut.user_type_name='||quote_literal(upper(i_user_type_name)) ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_type_id               := REC.user_type_id;
            v_return.user_type_name             := REC.user_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

