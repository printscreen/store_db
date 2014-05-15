DROP FUNCTION IF EXISTS set_order_shipping(
      i_order_shipping_id   BIGINT
    , i_order_id            BIGINT
    , i_address_id          BIGINT
    , i_first_name          CHARACTER VARYING
    , i_last_name           CHARACTER VARYING
    , i_shipping_cost       DOUBLE PRECISION
);
CREATE OR REPLACE FUNCTION set_order_shipping(
      i_order_shipping_id   BIGINT
    , i_order_id            BIGINT
    , i_address_id          BIGINT
    , i_first_name          CHARACTER VARYING
    , i_last_name           CHARACTER VARYING
    , i_shipping_cost       DOUBLE PRECISION
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_shipping;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_shipping WHERE order_shipping_id = i_order_shipping_id;
        
        IF v_old.order_shipping_id IS NULL THEN
            INSERT INTO transaction.order_shipping (
                insert_ts
              , update_ts
              , first_name
              , last_name
              , order_id
              , address_id
              , shipping_cost
            ) VALUES (
                  NOW()
                , NOW() 
                , i_first_name
                , i_last_name
                , i_order_id
                , i_address_id
                , i_shipping_cost
            );

            v_id := CURRVAL('transaction.order_shipping_order_shipping_id_seq');
        ELSE
            UPDATE transaction.order_shipping SET
                update_ts = NOW()
              , order_id = COALESCE(i_order_id, order_id)
              , address_id = COALESCE(i_address_id, address_id)
              , first_name = COALESCE(i_first_name, first_name)
              , last_name = COALESCE(i_last_name, last_name)
              , shipping_cost = COALESCE(i_shipping_cost, shipping_cost)
            WHERE
                order_shipping_id = v_old.order_shipping_id;

            v_id := v_old.order_shipping_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
