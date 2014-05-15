DROP FUNCTION IF EXISTS delete_ordered_sale_item (
    i_order_id      BIGINT
  , i_sale_item_id  BIGINT
);
CREATE OR REPLACE FUNCTION delete_ordered_sale_item (
    i_order_id      BIGINT
  , i_sale_item_id  BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    BEGIN
        IF i_order_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM sale_item_ordered WHERE order_id = i_order_id AND sale_item_id = i_sale_item_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
