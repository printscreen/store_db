DROP FUNCTION IF EXISTS update_kickstarter_order (
      i_kickstarter_id  BIGINT
    , i_shirt_type      CHARACTER VARYING
    , i_shirt_size      CHARACTER VARYING
);
CREATE OR REPLACE FUNCTION update_kickstarter_order (
      i_kickstarter_id  BIGINT
    , i_shirt_type      CHARACTER VARYING
    , i_shirt_size      CHARACTER VARYING 
    
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_kickstarter users.kickstarter;
        v_order transaction.order;
        v_order_history transaction.order_history;
        REC RECORD;
        v_order_id BIGINT;
        v_find_shirt BIGINT;
        v_shipping_cost BIGINT;
        v_order_status BIGINT;
    BEGIN
	    -- Find kickstarter
	    SELECT * INTO v_kickstarter FROM users.kickstarter WHERE kickstarter_id = i_kickstarter_id;
        IF v_kickstarter.kickstarter_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        IF v_kickstarter.tier_id > 3 THEN
            v_order_status = 1;
        ELSE
            v_order_status = 2;
        END IF;
        
        --Find order
        SELECT * INTO v_order FROM transaction.order WHERE order_id = v_kickstarter.order_id;
        IF v_kickstarter.country_id = 219 THEN
            v_shipping_cost = 0;
        ELSE
            v_shipping_cost = 1500;
        END IF;
        IF v_order.order_id IS NULL THEN
            INSERT INTO transaction.order (
                  user_id
                , transaction_id
                , order_status_id
                , shipping_cost
                , ship_to
                , bill_to
            ) VALUES (
                  v_kickstarter.user_id
                , 'kickstarter_' || v_kickstarter.kickstarter_id
                , v_order_status
                , v_shipping_cost
                , v_kickstarter.address_id
                , v_kickstarter.address_id
            );
            v_order_id = CURRVAL('transaction.order_order_id_seq');
            UPDATE users.kickstarter SET order_id = v_order_id WHERE kickstarter_id = v_kickstarter.kickstarter_id;
            PERFORM set_order_history(null,v_order_id,1,'Order Received',1);
        ELSE
            v_order_id = v_order.order_id;
        END IF;
        -- Delete any items
        DELETE FROM transaction.sale_item_ordered WHERE order_id = v_kickstarter.order_id;
        --Inserts items, tier_id and sale_item_id share the same number
        INSERT INTO transaction.sale_item_ordered 
            (order_id, 
             sale_item_id,
             price_paid,
             quantity,
             active
            ) 
        VALUES 
            (v_order_id,
             v_kickstarter.tier_id,
             (SELECT sum(amount) FROM transaction.kickstarter_pledge WHERE kickstarter_id = v_kickstarter.kickstarter_id),
             1,
             true);
        --Handle Shirt
        IF v_kickstarter.tier_id > 3 AND v_kickstarter.verified THEN
	        SELECT si.sale_item_id INTO v_find_shirt FROM inventory.sale_item si  WHERE name = 'Kickstarter T-Shirt '||upper(i_shirt_type)||upper(i_shirt_size);
	        INSERT INTO transaction.sale_item_ordered 
	            (order_id, 
	            sale_item_id,
	            price_paid,
	            quantity,
	            active
	            ) 
	        VALUES 
	            ( v_order_id,
	              v_find_shirt,
	              0,
	              1,
	              true
	            );
	    END IF;
	    
	    --Handle Notes/Order History
	    IF v_kickstarter.notes IS NOT NULL AND character_length(v_kickstarter.notes) > 0 THEN
	       
	       SELECT * INTO v_order_history FROM transaction.order_history WHERE order_id = v_order_id AND user_id = v_kickstarter.user_id;
	       IF v_order_history.order_history_id IS NULL THEN
	           INSERT INTO transaction.order_history
	               (insert_ts,
	               order_id,
	               user_id,
	               description,
	               order_history_type_id
	               )
	           VALUES
	               (NOW(),
	               v_order_id,
	               v_kickstarter.user_id,
	               v_kickstarter.notes,
	               4
	               );
	       ELSE
	           UPDATE transaction.order_history SET
	               description = COALESCE(v_kickstarter.notes, description)
	           WHERE
	               order_id = v_order_id
	           AND
	               user_id = v_kickstarter.user_id;
	       END IF;
	    END IF;
	    
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
