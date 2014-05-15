DROP FUNCTION IF EXISTS do_sale_items_have_physical_items (
    i_sale_item_ids     BIGINT[]
);
CREATE OR REPLACE FUNCTION do_sale_items_have_physical_items (
    i_sale_item_ids     BIGINT[]
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;

    BEGIN
        SELECT * INTO REC FROM inventory.sale_item_item sii INNER JOIN inventory.item i ON sii.item_id = i.item_id WHERE i.item_type_id = 1 AND sii.sale_item_id = ANY(i_sale_item_ids);
        IF FOUND THEN
            RETURN true;
        ELSE
            RETURN false;
        END IF;
    END;
$_$
LANGUAGE PLPGSQL;