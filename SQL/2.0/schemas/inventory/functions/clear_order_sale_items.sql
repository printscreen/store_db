DROP FUNCTION IF EXISTS clear_order_sale_item (
    i_order_id      BIGINT
);
CREATE OR REPLACE FUNCTION clear_order_sale_item (
    i_order_id      BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    BEGIN
        IF i_order_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM sale_item_ordered WHERE order_id = i_order_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
