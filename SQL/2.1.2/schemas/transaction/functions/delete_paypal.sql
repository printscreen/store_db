DROP FUNCTION IF EXISTS delete_paypal(
    i_paypal_id BIGINT
);
CREATE OR REPLACE FUNCTION delete_paypal (
    i_paypal_id BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    BEGIN
        IF i_paypal_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM transaction.paypal WHERE paypal_id = i_paypal_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
