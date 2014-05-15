DROP FUNCTION IF EXISTS set_sale_key (
   i_sale_key_id       BIGINT
 , i_key               TEXT
 , i_order_id          BIGINT
 , i_sale_item_id      BIGINT
 , i_item_id           BIGINT
);

CREATE OR REPLACE FUNCTION set_sale_key (
   i_sale_key_id       BIGINT
 , i_key               TEXT
 , i_order_id          BIGINT
 , i_sale_item_id      BIGINT
 , i_item_id           BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.sale_key;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.sale_key WHERE sale_key_id = i_sale_key_id;

        IF v_old.sale_key_id IS NULL THEN
            INSERT INTO transaction.sale_key (
                  key
                , order_id
                , sale_item_id
                , item_id
            ) VALUES (
                  i_key
                , i_order_id
                , i_sale_item_id
                , i_item_id
            );

            v_id := CURRVAL('transaction.sale_key_sale_key_id_seq');
        ELSE
            UPDATE transaction.sale_key SET
                  key = COALESCE(i_key_id, key)
                , order_id = COALESCE(i_order_id, order_id)
                , sale_item_id = COALESCE(i_sale_item_id, sale_item_id)
                , item_id = COALESCE(i_item_id, item_id)
            WHERE
                sale_key_id = v_old.sale_key_id;

            v_id := v_old.sale_key_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
