DROP FUNCTION IF EXISTS get_item_file_path_orgin (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_item_file_path_orgin (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_item_file_path_orgin
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item_file_path_orgin;
    BEGIN
        
        v_sql := '
            SELECT 
                 ifpo.item_file_path_orgin_id        AS item_file_path_orgin_id
                ,ifpo.item_file_path_orgin_name      AS item_file_path_orgin_name
                ,( SELECT COUNT(*)
                         FROM inventory.v_item_file_path_orgin ifpo
                       )::BIGINT                   AS total
            FROM inventory.v_item_file_path_orgin ifpo
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_file_path_orgin_id               := REC.item_file_path_orgin_id;
            v_return.item_file_path_orgin_name             := REC.item_file_path_orgin_name;
            v_return.total                                 := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;



DROP FUNCTION IF EXISTS get_item_file_path_orgin (
    i_item_file_path_orgin_id        BIGINT
);
CREATE OR REPLACE FUNCTION get_item_file_path_orgin (
    i_item_file_path_orgin_id        BIGINT
)
RETURNS SETOF inventory.t_item_file_path_orgin
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item_file_path_orgin;
    BEGIN
        IF i_item_file_path_orgin_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 ifpo.item_file_path_orgin_id        AS item_file_path_orgin_id
                ,ifpo.item_file_path_orgin_name      AS item_file_path_orgin_name
                ,1                                   AS total
            FROM inventory.v_item_file_path_orgin ifpo
            WHERE ifpo.item_file_path_orgin_id='||i_item_file_path_orgin_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_file_path_orgin_id               := REC.item_file_path_orgin_id;
            v_return.item_file_path_orgin_name             := REC.item_file_path_orgin_name;
            v_return.total                                 := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

