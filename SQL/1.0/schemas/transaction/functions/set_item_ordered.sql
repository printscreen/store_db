DROP FUNCTION IF EXISTS set_item_ordered(
        i_item_ordered_id   BIGINT
      , i_order_id          BIGINT
      , i_item_id           BIGINT
      , i_quantity          BIGINT
      , i_active            BOOLEAN
);

CREATE OR REPLACE FUNCTION set_item_ordered(
        i_item_ordered_id   BIGINT
      , i_order_id          BIGINT
      , i_item_id           BIGINT
      , i_quantity          BIGINT
      , i_active            BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.item_ordered;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.item_ordered WHERE item_ordered_id = i_item_ordered_id;

        IF v_old.item_ordered_id IS NULL THEN
            INSERT INTO transaction.item_ordered (
                insert_ts
              , update_ts
              , order_id
              , item_id
              , quantity
              , active
            ) VALUES (
                NOW()
              , NOW()
              , i_order_id
              , i_item_id
              , i_quantity
              , i_active
            );

            v_id := CURRVAL('transaction.item_ordered_item_ordered_id_seq');
        ELSE
            UPDATE transaction.item_ordered SET
                update_ts = NOW()
              , order_id = COALESCE(i_order_id, order_id)
              , item_id = COALESCE(i_item_id, item_id)
              , quantity = COALESCE(i_quantity, quantity)
              , active = COALESCE(i_active, active)
            WHERE
                item_ordered_id = v_old.item_ordered_id;

            v_id := v_old.item_ordered_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
