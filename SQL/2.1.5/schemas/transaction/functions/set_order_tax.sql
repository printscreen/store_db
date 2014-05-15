DROP FUNCTION IF EXISTS set_order_tax (
    i_order_tax_id  BIGINT
  , i_order_id      BIGINT
  , i_tax_id        BIGINT
  , i_rate          DOUBLE PRECISION
);
CREATE OR REPLACE FUNCTION set_order_tax (
    i_order_tax_id  BIGINT
  , i_order_id      BIGINT
  , i_tax_id        BIGINT
  , i_rate          DOUBLE PRECISION
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_tax;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_tax WHERE order_tax_id = i_order_tax_id;

        IF v_old.order_tax_id IS NULL THEN
            INSERT INTO transaction.order_tax (
                  order_id
                , tax_id
                , rate
                , insert_ts
            ) VALUES (
                  i_order_id
                , i_tax_id
                , i_rate
                , NOW()
            );

            v_id := CURRVAL('transaction.order_tax_order_tax_id_seq');
        ELSE
            UPDATE transaction.order_tax SET
                  order_id = COALESCE(i_order_id, order_id)
                , tax_id = COALESCE(i_tax_id, tax_id)
                , rate = COALESCE(i_rate, rate)
            WHERE
                order_tax_id = v_old.order_tax_id;

            v_id := v_old.order_tax_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
