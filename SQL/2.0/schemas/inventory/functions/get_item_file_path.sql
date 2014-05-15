DROP FUNCTION IF EXISTS get_item_file_path (
    i_item_id        BIGINT
);
CREATE OR REPLACE FUNCTION get_item_file_path (
    i_item_id        BIGINT
)
RETURNS SETOF inventory.t_item_file_path
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item_file_path;
    BEGIN
        IF i_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 ifp.item_file_path_id          AS item_file_path_id
                ,ifp.item_id                    AS item_id
                ,ifp.item_name                  AS item_name
                ,ifp.file_path                  AS file_path
                ,ifp.item_file_path_orgin_id    AS item_file_path_orgin_id
                ,ifp.item_file_path_orgin_name  AS item_file_path_orgin_name
                ,1                              AS total
            FROM inventory.v_item_file_path ifp
            WHERE ifp.item_id='||i_item_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_file_path_id          := REC.item_file_path_id;
            v_return.item_id                    := REC.item_id;
            v_return.item_name                  := REC.item_name;
            v_return.file_path                  := REC.file_path;
            v_return.item_file_path_orgin_id    := REC.item_file_path_orgin_id;
            v_return.item_file_path_orgin_name  := REC.item_file_path_orgin_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;