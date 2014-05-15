DROP FUNCTION IF EXISTS delete_address (
    i_address_id     BIGINT
);
CREATE OR REPLACE FUNCTION delete_address (
    i_address_id     BIGINT
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_address transaction.address;
        v_order transaction.order;
    BEGIN
        SELECT * INTO v_address FROM transaction.address WHERE address_id = i_address_id;
        IF v_address.address_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        SELECT * INTO v_order FROM transaction.order WHERE ship_to = i_address_id OR bill_to = i_address_id LIMIT 1;
        
        --If the address is not used in any shipping or billing orders, just delete it
        IF v_order.order_id IS NULL THEN
            DELETE FROM transaction.address WHERE address_id = i_address_id;
        ELSE
        -- If it is in use, set active to false because we need it for historical purposes
            UPDATE transaction.address SET active = false WHERE address_id = i_address_id;
        END IF;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
