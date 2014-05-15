DROP FUNCTION IF EXISTS set_sale_item_item (
      i_sale_item_item_id   BIGINT
    , i_sale_item_id        BIGINT
    , i_item_id             BIGINT
    , i_quantity            BIGINT
);
CREATE OR REPLACE FUNCTION set_sale_item_item (
      i_sale_item_item_id   BIGINT
    , i_sale_item_id        BIGINT
    , i_item_id             BIGINT
    , i_quantity            BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_item_item;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_item_item WHERE sale_item_item_id = i_sale_item_item_id;
        IF v_old.sale_item_item_id IS NULL THEN
            SELECT * INTO v_old FROM inventory.sale_item_item WHERE sale_item_id = i_sale_item_id AND item_id = i_item_id;
        END IF;

        IF v_old.sale_item_item_id IS NULL THEN
            INSERT INTO inventory.sale_item_item (
                    sale_item_id
                  , item_id
                  , quantity
            ) VALUES (
                    i_sale_item_id
                  , i_item_id
                  , i_quantity
            );

            v_id := CURRVAL('inventory.sale_item_item_sale_item_item_id_seq');
        ELSE
            UPDATE inventory.sale_item_item SET
                  sale_item_id = COALESCE(i_sale_item_id, sale_item_id)
                , item_id = COALESCE(i_item_id, item_id)
                , quantity = COALESCE(i_quantity, quantity)
            WHERE
                sale_item_item_id = v_old.sale_item_item_id;

            v_id := v_old.sale_item_item_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
