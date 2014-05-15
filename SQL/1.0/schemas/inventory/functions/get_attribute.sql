DROP FUNCTION IF EXISTS get_attribute(
    i_attribute_id  BIGINT
);
CREATE OR REPLACE FUNCTION get_attribute (
    i_attribute_id  BIGINT
)
RETURNS SETOF inventory.t_attribute
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_attribute;
    BEGIN
        IF i_attribute_id IS NULL THEN
            RETURN;
        END IF;
	    
	    v_sql := '
            SELECT 
                 a.attribute_id     AS attribute_id
                ,a.attribute_name   AS attribute_name
                ,a.parent_id        AS parent_id
            FROM inventory.v_attribute a
            WHERE a.attribute_id='||i_attribute_id ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.attribute_id       := REC.attribute_id;
            v_return.attribute_name     := REC.attribute_name;
            v_return.parent_id          := REC.parent_id;
            v_return.total              := 1;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_attribute(
    i_attribute_name    VARCHAR
);
CREATE OR REPLACE FUNCTION get_attribute (
    i_attribute_name    VARCHAR   
)
RETURNS SETOF inventory.t_attribute
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_attribute;
    BEGIN
        IF i_attribute_id IS NULL THEN
            RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 a.attribute_id     AS attribute_id
                ,a.attribute_name   AS attribute_name
                ,a.parent_id        AS parent_id
            FROM inventory.v_attribute a
            WHERE a.attribute_name='||quote_literal(i_attribute_name) ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.attribute_id       := REC.attribute_id;
            v_return.attribute_name     := REC.attribute_name;
            v_return.parent_id          := REC.parent_id;
            v_return.total              := 1;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_attribute (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_attribute (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_attribute
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_attribute;
    BEGIN
        v_sql := '
            SELECT 
                 a.attribute_id     AS attribute_id
                ,a.attribute_name   AS attribute_name
                ,a.parent_id        AS parent_id
                ,( SELECT COUNT(*)
                         FROM inventory.v_attribute a
                       )::BIGINT   AS total
            FROM inventory.v_attribute a 
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.attribute_id       := REC.attribute_id;
            v_return.attribute_name     := REC.attribute_name;
            v_return.parent_id          := REC.parent_id;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_attribute (
    i_parent_id         BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_attribute (
    i_parent_id         BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_attribute
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_attribute;
    BEGIN
        v_sql := '
            SELECT 
                 a.attribute_id     AS attribute_id
                ,a.attribute_name   AS attribute_name
                ,a.parent_id        AS parent_id
                ,( SELECT COUNT(*)
                         FROM inventory.v_attribute a WHERE '||COALESCE('a.parent_id='||i_parent_id, 'a.parent_id IS NULL')||'
                       )::BIGINT   AS total
            FROM inventory.v_attribute a
            WHERE '
            ||COALESCE('a.parent_id='||i_parent_id, 'a.parent_id IS NULL')|| 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.attribute_id       := REC.attribute_id;
            v_return.attribute_name     := REC.attribute_name;
            v_return.parent_id          := REC.parent_id;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

