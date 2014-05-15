DROP FUNCTION IF EXISTS get_item_type (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_item_type (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_item_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item_type;
    BEGIN
        
        v_sql := '
            SELECT 
                 it.item_type_id        AS item_type_id
                ,it.item_type_name      AS item_type_name
                ,( SELECT COUNT(*)
                         FROM inventory.v_item_type it
                       )::BIGINT       AS total
            FROM inventory.v_item_type it
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_type_id               := REC.item_type_id;
            v_return.item_type_name             := REC.item_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;



DROP FUNCTION IF EXISTS get_item_type (
    i_item_type_id        BIGINT
);
CREATE OR REPLACE FUNCTION get_item_type (
    i_item_type_id        BIGINT
)
RETURNS SETOF inventory.t_item_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item_type;
    BEGIN
        IF i_item_type_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 it.item_type_id        AS item_type_id
                ,it.item_type_name      AS item_type_name
                ,1                      AS total
            FROM inventory.item_type it
            WHERE it.item_type_id='||i_item_type_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_type_id               := REC.item_type_id;
            v_return.item_type_name             := REC.item_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

