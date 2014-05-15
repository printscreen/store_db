DROP FUNCTION IF EXISTS set_order_billing(
      i_order_billing_id        BIGINT
    , i_order_id                BIGINT
    , i_address_id              BIGINT
    , i_first_name              CHARACTER VARYING
    , i_last_name               CHARACTER VARYING
    , i_authorization_number    CHARACTER VARYING
);
CREATE OR REPLACE FUNCTION set_order_billing(
      i_order_billing_id       BIGINT
    , i_order_id                BIGINT
    , i_address_id              BIGINT
    , i_first_name              CHARACTER VARYING
    , i_last_name               CHARACTER VARYING
    , i_authorization_number    CHARACTER VARYING
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_billing;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_billing WHERE order_billing_id = i_order_billing_id;
        
        IF v_old.order_billing_id IS NULL THEN
            INSERT INTO transaction.order_billing (
                insert_ts
              , update_ts
              , first_name
              , last_name
              , order_id
              , address_id
              , authorization_number
            ) VALUES (
                  NOW()
                , NOW() 
                , i_first_name
                , i_last_name
                , i_order_id
                , i_address_id
                , i_authorization_number
            );

            v_id := CURRVAL('transaction.order_billing_order_billing_id_seq');
        ELSE
            UPDATE transaction.order_billing SET
                update_ts = NOW()
              , order_id = COALESCE(i_order_id, order_id)
              , address_id = COALESCE(i_address_id, address_id)
              , first_name = COALESCE(i_first_name, first_name)
              , last_name = COALESCE(i_last_name, last_name)
              , authorization_number = COALESCE(i_authorization_number, authorization_number)
            WHERE
                order_billing_id = v_old.order_billing_id;

            v_id := v_old.order_billing_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
