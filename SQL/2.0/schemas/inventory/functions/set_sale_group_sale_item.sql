DROP FUNCTION IF EXISTS set_sale_group_sale_item (
      i_sale_group_sale_item_id BIGINT
    , i_sale_group_id           BIGINT
    , i_sale_item_id            BIGINT
);
CREATE OR REPLACE FUNCTION set_sale_group_sale_item (
      i_sale_group_sale_item_id BIGINT
    , i_sale_group_id           BIGINT
    , i_sale_item_id            BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_group_sale_item;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_group_sale_item WHERE sale_group_sale_item_id = i_sale_group_sale_item_id;
        IF v_old.sale_group_sale_item_id IS NULL THEN
            SELECT * INTO v_old FROM inventory.sale_group_sale_item WHERE sale_group_id = i_sale_group_id AND sale_item_id = i_sale_item_id;
        END IF;

        IF v_old.sale_group_sale_item_id IS NULL THEN
            INSERT INTO inventory.sale_group_sale_item (
                    sale_group_id
                  , sale_item_id
            ) VALUES (
                    i_sale_group_id
                  , i_sale_item_id
            );

            v_id := CURRVAL('inventory.sale_group_sale_item_sale_group_sale_item_id_seq');
        ELSE
            UPDATE inventory.sale_group_sale_item SET
                  sale_group_id = COALESCE(i_sale_group_id, sale_group_id)
                , sale_item_id = COALESCE(i_sale_item_id, sale_item_id)
            WHERE
                sale_group_sale_item_id = v_old.sale_group_sale_item_id;

            v_id := v_old.sale_group_sale_item_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
