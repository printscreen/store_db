DROP FUNCTION IF EXISTS get_resource_group (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_resource_group (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_resource_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_resource_group;
    BEGIN
        v_sql := '
            SELECT 
                 rg.resource_group_id   AS resource_group_id
                ,rg.name                AS name
                ,rg.description         AS description
                ,( SELECT COUNT(*)
                         FROM application.v_resource_group rg
                       )::BIGINT       AS total
            FROM application.v_resource_group rg
            ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.resource_group_id          := REC.resource_group_id;
            v_return.name                       := REC.name;
            v_return.description                := REC.description;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_resource_group (
    i_resource_group_id BIGINT
);
CREATE OR REPLACE FUNCTION get_resource_group (
    i_resource_group_id BIGINT
)
RETURNS SETOF application.t_resource_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_resource_group;
    BEGIN
        IF i_resource_group_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 rg.resource_group_id   AS resource_group_id
                ,rg.name                AS name
                ,rg.description         AS description
                ,1                      AS total
            FROM application.resource_group rg
            WHERE rg.resource_group_id='||i_resource_group_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.resource_group_id          := REC.resource_group_id;
            v_return.name                       := REC.name;
            v_return.description                := REC.description;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_resource_group (
    i_name           VARCHAR
);
CREATE OR REPLACE FUNCTION get_resource_group (
    i_name           VARCHAR
)
RETURNS SETOF application.t_resource_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_resource_group;
    BEGIN
        IF i_name IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 rg.resource_group_id   AS resource_group_id
                ,rg.name                AS name
                ,rg.description         AS description
                ,( SELECT COUNT(*)
                         FROM application.resource_group rg WHERE true '|| COALESCE(' AND rg.name='||quote_literal(i_name), '') ||'
                       )::BIGINT       AS total
            FROM application.resource_group rg
            WHERE TRUE'
            || COALESCE(' AND rg.name='||quote_literal(i_name), '') || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.resource_group_id          := REC.resource_group_id;
            v_return.name                       := REC.name;
            v_return.description                := REC.description;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_resource_group (
    i_user_type_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_resource_group (
    i_user_type_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_resource_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_resource_group;
    BEGIN
	    IF i_user_type_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 rg.resource_group_id   AS resource_group_id
                ,rg.name                AS name
                ,rg.description         AS description
                ,rg.user_type_id        AS user_type_id
                ,( SELECT COUNT(*)
                         FROM application.v_user_type_resource_group rg WHERE rg.user_type_id = ' || i_user_type_id || '
                       )::BIGINT       AS total
            FROM application.v_user_type_resource_group rg
            WHERE rg.user_type_id = ' || i_user_type_id || '
            ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.resource_group_id          := REC.resource_group_id;
            v_return.name                       := REC.name;
            v_return.description                := REC.description;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

