DROP FUNCTION IF EXISTS set_order_history_type(
        i_order_history_type_id     BIGINT
      , i_order_history_type_name   VARCHAR
);
CREATE OR REPLACE FUNCTION set_order_history_type(
        i_order_history_type_id     BIGINT
      , i_order_history_type_name   VARCHAR
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_history_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_history_type WHERE order_history_type_id = i_order_history_type_id;

        IF v_old.order_history_type_id IS NULL THEN
            INSERT INTO transaction.order_history_type (
                  name
            ) VALUES (
                  i_order_history_type_name
            );

            v_id := CURRVAL('transaction.order_history_type_order_history_type_id_seq');
        ELSE
            UPDATE transaction.order_history_type SET
                  name = COALESCE(i_order_history_type_name, name)
            WHERE
                order_history_type_id = v_old.order_history_type_id;

            v_id := v_old.order_history_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
