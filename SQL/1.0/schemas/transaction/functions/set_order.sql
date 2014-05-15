DROP FUNCTION IF EXISTS set_order(
        i_order_id          BIGINT
      , i_user_id           BIGINT
      , i_transaction_id    VARCHAR(255)
      , i_order_status_id   BIGINT
);

CREATE OR REPLACE FUNCTION set_order(
        i_order_id          BIGINT
      , i_user_id           BIGINT
      , i_transaction_id    VARCHAR(255)
      , i_order_status_id   BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order WHERE order_id = i_order_id;

        IF v_old.order_id IS NULL THEN
            INSERT INTO transaction.order (
                  user_id
                , transaction_id
                , order_status_id
            ) VALUES (
                  i_user_id
                , i_transaction_id
                , i_order_status_id
            );

            v_id := CURRVAL('transaction.order_order_id_seq');
        ELSE
            UPDATE transaction.order SET
                  user_id = COALESCE(i_user_id, user_id)
                , transaction_id = COALESCE(i_transaction_id, transaction_id)
                , order_status_id = COALESCE(i_order_status_id, order_status_id)
            WHERE
                order_id = v_old.order_id;

            v_id := v_old.order_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
