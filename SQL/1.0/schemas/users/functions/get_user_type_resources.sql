DROP FUNCTION IF EXISTS get_user_type_resource (
    i_user_type_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_user_type_resource (
    i_user_type_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF users.t_user_type_resource
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user_type_resource;
    BEGIN
	    
	    IF i_user_type_id IS NULL THEN
	       return;
	    END IF;
	    
        v_sql := '
            SELECT 
                 utr.user_type_resource_id       AS user_type_id
                ,utr.user_type_id                AS user_type_id
                ,utr.user_type_name              AS user_type_name
                ,utr.resource_id                 AS resource_id
                ,utr.resource_name               AS resource_name
            FROM users.v_user_type_resource utr
            WHERE true'
            || COALESCE(' AND utr.user_type_id='||i_user_type_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        -- RAISE INFO '%', v_sql;
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_type_resource_id  := REC.user_type_id;
            v_return.user_type_id           := REC.user_type_id;
            v_return.user_type_name         := REC.user_type_name;
            v_return.resource_id            := REC.resource_id;
            v_return.resource_name          := REC.resource_name;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
