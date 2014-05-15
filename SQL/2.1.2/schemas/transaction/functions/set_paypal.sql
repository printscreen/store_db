DROP FUNCTION IF EXISTS set_paypal (
        i_paypal_id         BIGINT
      , i_user_id           BIGINT
      , i_order_status_id   BIGINT
      , i_shipping_cost     BIGINT
      , i_ship_to           BIGINT
      , i_bill_to           BIGINT
      , i_token             VARCHAR(255)
      , i_cart              TEXT
);
CREATE OR REPLACE FUNCTION set_paypal (
        i_paypal_id         BIGINT
      , i_user_id           BIGINT
      , i_order_status_id   BIGINT
      , i_shipping_cost     BIGINT
      , i_ship_to           BIGINT
      , i_bill_to           BIGINT
      , i_token             VARCHAR(255)
      , i_cart              TEXT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.paypal;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.paypal WHERE paypal_id = i_paypal_id;
        IF v_old.paypal_id IS NULL THEN
            SELECT * INTO v_old FROM transaction.paypal WHERE token = quote_literal(i_token);
        END IF;

        IF v_old.paypal_id IS NULL THEN
            INSERT INTO transaction.paypal (
                  user_id
                , order_status_id
                , shipping_cost
                , ship_to
                , bill_to
                , token
                , cart
            ) VALUES (
                  i_user_id
                , i_order_status_id
                , i_shipping_cost
                , i_ship_to
                , i_bill_to
                , i_token
                , i_cart
            );

            v_id := CURRVAL('transaction.paypal_paypal_id_seq');
        ELSE
            UPDATE transaction.paypal SET
                  user_id = COALESCE(i_user_id, user_id)
                , order_status_id = COALESCE(i_order_status_id, order_status_id)
                , shipping_cost = COALESCE(i_shipping_cost, shipping_cost)
                , ship_to = COALESCE(i_ship_to, ship_to)
                , bill_to = COALESCE(i_bill_to, bill_to)
                , token = COALESCE(i_token, token)
                , cart = COALESCE(i_cart, cart)
            WHERE
                paypal_id = v_old.paypal_id;

            v_id := v_old.paypal_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
