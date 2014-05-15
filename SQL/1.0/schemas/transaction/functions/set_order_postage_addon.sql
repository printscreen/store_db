DROP FUNCTION IF EXISTS set_order_postage_addon(
        i_carrier_addon_id  BIGINT
      , i_order_postage_id  BIGINT
);
CREATE OR REPLACE FUNCTION set_order_postage_addon(
        i_carrier_addon_id  BIGINT
      , i_order_postage_id  BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_postage_addon;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_postage_addon WHERE carrier_addon_id = i_carrier_addon_id AND order_postage_id = i_order_postage_id;

        IF v_old.order_postage_addon_id IS NULL THEN
            INSERT INTO transaction.order_postage_addon (
                  carrier_addon_id
                , order_postage_id
            ) VALUES (
                  i_carrier_addon_id
                , i_order_postage_id
            );

            v_id := CURRVAL('transaction.order_postage_addon_order_postage_addon_id_seq');
        ELSE
            v_id := v_old.order_postage_addon_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
