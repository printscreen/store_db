DROP FUNCTION IF EXISTS delete_sale_group_sale_item (
    i_sale_group_sale_item_id   BIGINT
);
CREATE OR REPLACE FUNCTION delete_sale_group_sale_item (
    i_sale_group_sale_item_id   BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_group_sale_item;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_group_sale_item WHERE sale_group_sale_item_id = i_sale_group_sale_item_id;
        IF v_old.sale_group_sale_item_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM inventory.sale_group_sale_item WHERE sale_group_sale_item_id = i_sale_group_sale_item_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
