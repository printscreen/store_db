DROP FUNCTION IF EXISTS delete_order_postage (
    i_order_postage_id           BIGINT
);
CREATE OR REPLACE FUNCTION delete_order_postage (
    i_order_postage_id           BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    BEGIN        
        DELETE FROM transaction.order_postage WHERE order_postage_id = i_order_postage_id;
        
        RETURN true;
    END;
$_$
LANGUAGE PLPGSQL;
