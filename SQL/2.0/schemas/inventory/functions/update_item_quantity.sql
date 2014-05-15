DROP FUNCTION IF EXISTS update_item_quantity (
    i_item_id   BIGINT
  , i_quantity  BIGINT
);
CREATE OR REPLACE FUNCTION update_item_quantity (
    i_item_id   BIGINT
  , i_quantity  BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.item;
    BEGIN
        SELECT * INTO v_old FROM inventory.item WHERE item_id = i_item_id;
        IF v_old.item_id IS NULL THEN
            RETURN FALSE;
        END IF;
        UPDATE inventory.item SET quantity = (
            v_old.quantity + i_quantity
        ) WHERE item_id = v_old.item_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;