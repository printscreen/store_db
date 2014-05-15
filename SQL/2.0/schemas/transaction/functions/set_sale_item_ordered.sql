DROP FUNCTION IF EXISTS set_item_ordered(
        i_item_ordered_id   BIGINT
      , i_order_id          BIGINT
      , i_item_id           BIGINT
      , i_quantity          BIGINT
      , i_active            BOOLEAN
);
DROP FUNCTION IF EXISTS set_sale_item_ordered(
        i_sale_item_ordered_id  BIGINT
      , i_order_id              BIGINT
      , i_sale_item_id          BIGINT
      , i_price_paid            BIGINT
      , i_quantity              BIGINT
      , i_active                BOOLEAN
);
CREATE OR REPLACE FUNCTION set_sale_item_ordered(
        i_sale_item_ordered_id  BIGINT
      , i_order_id              BIGINT
      , i_sale_item_id          BIGINT
      , i_price_paid            BIGINT
      , i_quantity              BIGINT
      , i_active                BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.sale_item_ordered;
        v_item inventory.item;
        v_key inventory.key;
        v_sale_item_item inventory.sale_item_item;
        v_new_amount BIGINT;
        v_old_amount BIGINT;
        v_id BIGINT;
        v_item_file_path inventory.item_file_path;
    BEGIN
        SELECT * INTO v_old FROM transaction.sale_item_ordered WHERE sale_item_ordered_id = i_sale_item_ordered_id;

        IF v_old.sale_item_ordered_id IS NULL THEN
            INSERT INTO transaction.sale_item_ordered (
                insert_ts
              , update_ts
              , order_id
              , sale_item_id
              , price_paid
              , quantity
              , active
            ) VALUES (
                NOW()
              , NOW()
              , i_order_id
              , i_sale_item_id
              , i_price_paid
              , i_quantity
              , i_active
            );
            
            -- Update item quantites
            FOR v_sale_item_item IN SELECT * FROM inventory.sale_item_item sii WHERE sii.sale_item_id = i_sale_item_id LOOP
                 SELECT * INTO v_item FROM inventory.item i WHERE item_id = v_sale_item_item.item_id;
                 IF v_item.item_id IS NOT NULL AND v_item.item_type_id != 2 THEN
                    v_new_amount = (v_item.quantity - (i_quantity * v_sale_item_item.quantity));
                    UPDATE inventory.item SET quantity = v_new_amount WHERE item_id = v_item.item_id;
                 END IF;
                 
                 -- Handle inserting digital keys
                 SELECT * INTO v_item_file_path FROM inventory.item_file_path ifp WHERE ifp.item_id = v_item.item_id;
                 IF v_item_file_path.item_file_path_id IS NOT NULL AND v_item_file_path.item_file_path_orgin_id = 4 THEN
                    FOR v_key IN SELECT * FROM inventory.key k WHERE k.item_id = v_item.item_id LIMIT (i_quantity * v_sale_item_item.quantity) LOOP
                        INSERT INTO transaction.sale_key (
                            key
                          , order_id
                          , sale_item_id
                          , item_id
                        ) VALUES (
                            v_key.key
                          , i_order_id
                          , i_sale_item_id
                          , v_item.item_id
                        );
                        DELETE FROM inventory.key WHERE key_id = v_key.key_id;
                    END LOOP;
                    v_new_amount = ((SELECT count(*) FROM inventory.key WHERE item_id = v_item.item_id) - (i_quantity * v_sale_item_item.quantity));
                    UPDATE inventory.item SET quantity = v_new_amount WHERE item_id = v_item.item_id;
                 END IF;
            END LOOP;
            v_id := CURRVAL('transaction.sale_item_ordered_sale_item_ordered_id_seq');
        ELSE
            IF i_quantity IS NOT NULL THEN
                SELECT quantity INTO v_old_amount FROM transaction.sale_item_ordered WHERE sale_item_ordered_id = v_old.sale_item_ordered_id;
                IF v_old_amount > i_quantity THEN
                    -- If they are removing sale items, increase the inventory amount by the difference
                    FOR v_sale_item_item IN SELECT * FROM inventory.sale_item_item sii WHERE sii.sale_item_id = i_sale_item_id LOOP
		                 SELECT * INTO v_item FROM inventory.item i WHERE item_id = v_sale_item_item.item_id;
		                 IF v_item.item_id IS NOT NULL AND v_item.item_type_id != 2 THEN
		                    v_new_amount = (v_item.quantity + ((v_old_amount - i_quantity) * v_sale_item_item.quantity));
		                    UPDATE inventory.item SET quantity = v_new_amount WHERE item_id = v_item.item_id;
		                 END IF;
		            END LOOP;
                ELSE
                    -- If they are adding more sale item, decrease the amount of items by the difference
                    FOR v_sale_item_item IN SELECT * FROM inventory.sale_item_item sii WHERE sii.sale_item_id = i_sale_item_id LOOP
                         SELECT * INTO v_item FROM inventory.item i WHERE item_id = v_sale_item_item.item_id;
                         IF v_item.item_id IS NOT NULL AND v_item.item_type_id != 2  THEN
                            v_new_amount = (v_item.quantity - ((i_quantity - v_old_amount) * v_sale_item_item.quantity));
                            UPDATE inventory.item SET quantity = v_new_amount WHERE item_id = v_item.item_id;
                         END IF;
                    END LOOP;
                END IF;
            END IF;
        
            UPDATE transaction.sale_item_ordered SET
                update_ts = NOW()
              , order_id = COALESCE(i_order_id, order_id)
              , sale_item_id = COALESCE(i_sale_item_id, sale_item_id)
              , price_paid = COALESCE(i_price_paid, price_paid)
              , quantity = COALESCE(i_quantity, quantity)
              , active = COALESCE(i_active, active)
            WHERE
                sale_item_ordered_id = v_old.sale_item_ordered_id;

            v_id := v_old.sale_item_ordered_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
