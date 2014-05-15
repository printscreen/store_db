/*  $Id:$
    $URL:$ 
    
    *
    * Function to create simulated data for ZPP
    *
    **/

CREATE OR REPLACE FUNCTION populating()

RETURNS VOID
SECURITY DEFINER
AS
$$
    DECLARE
    /*  $Id:$
        $URL:$ */
        REC        RECORD;
        v_seq      INT := 0;

        
    BEGIN
           
        SET statement_timeout = 0;
        FOR REC IN

            SELECT generate_series AS id FROM generate_series(0,2000000) 

        LOOP
        
            /* users.users */
            
            EXECUTE 'INSERT INTO users.user (
                first_name
              , last_name
              , email
              , password
              , user_type_id
              , active
              , update_ts
            ) VALUES (
                ' || quote_literal('first' || REC.id) || '
              , ' || quote_literal('last' || REC.id) || '
              , ' || quote_literal(REC.id || '@testdata.com') || '
              , ' || quote_literal('pass' || REC.id) || '
              , 2
              , true
              , (SELECT NOW())
            )';
            
            /* transaction.order */
            
            EXECUTE 'INSERT INTO transaction.order (
                  user_id
                , transaction_id
                , order_status_id
            ) VALUES (
                  ( SELECT CURRVAL($_$users.user_user_id_seq$_$))
                , '|| quote_literal('Transaction ' || REC.id) ||'
                , 1
            )';

            /* transaction.item_ordered */

            EXECUTE 'INSERT INTO transaction.item_ordered (
                insert_ts
              , update_ts
              , order_id
              , item_id
              , quantity
              , active
            ) VALUES (
                (SELECT NOW())
              , (SELECT NOW())
              , ( SELECT CURRVAL($_$transaction.order_order_id_seq$_$))
              , 1
              , 1
              , true
            )';

            /* transaction.address */

            EXECUTE 'INSERT INTO transaction.address (
                insert_ts
              , update_ts
              , street
              , unit_number
              , city
              , state
              , postal_code
              , country_id
              , user_id
              , active
              , hash
            ) VALUES (
                  (SELECT NOW())
                , (SELECT NOW()) 
                , '|| quote_literal('Street ' || REC.id) ||'
                , '|| quote_literal('Unit ' || REC.id) ||'
                , '|| quote_literal('City ' || REC.id) ||'
                , '|| quote_literal('State ' || REC.id) ||'
                , '|| quote_literal('Zip ' || REC.id) ||'
                , 224
                , ( SELECT CURRVAL($_$users.user_user_id_seq$_$))
                , true
                , md5('|| quote_literal(REC.id) ||')
            )';
            
            /* transaction.order_billing */
            
            EXECUTE 'INSERT INTO transaction.order_billing (
                insert_ts
              , update_ts
              , first_name
              , last_name
              , order_id
              , address_id
              , authorization_number
            ) VALUES (
                  (SELECT NOW())
                , (SELECT NOW()) 
                , ' || quote_literal('first' || REC.id) ||'
                , ' || quote_literal('last' || REC.id) ||'
                , ( SELECT CURRVAL($_$transaction.order_order_id_seq$_$))
                , ( SELECT CURRVAL($_$transaction.address_address_id_seq$_$))
                , 123
            )';

            /* transaction.order_shipping */
            EXECUTE 'INSERT INTO transaction.order_shipping (
                insert_ts
              , update_ts
              , first_name
              , last_name
              , order_id
              , address_id
              , shipping_cost
            ) VALUES (
                  (SELECT NOW())
                , (SELECT NOW()) 
                , ' || quote_literal('first' || REC.id) ||'
                , ' || quote_literal('last' || REC.id) ||'
                , ( SELECT CURRVAL($_$transaction.order_order_id_seq$_$))
                , ( SELECT CURRVAL($_$transaction.address_address_id_seq$_$))
                , 395
            )';


                           
        END LOOP;
                
    END;
$$
LANGUAGE PLPGSQL;
