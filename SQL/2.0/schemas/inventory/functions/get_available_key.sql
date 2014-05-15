DROP FUNCTION IF EXISTS get_available_key (
    i_item_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_available_key (
    i_item_id           BIGINT
)
RETURNS SETOF inventory.t_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_key;
    BEGIN
        IF i_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 k.key_id           AS key_id
                ,k.key              AS key
                ,k.item_id          AS item_id
                ,k.item_name        AS item_name
                ,1                  AS total
            FROM inventory.v_key k
            WHERE k.item_id='||i_item_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.key_id             := REC.key_id;
            v_return.key                := REC.key;
            v_return.item_id            := REC.item_id;
            v_return.item_name          := REC.item_name;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;