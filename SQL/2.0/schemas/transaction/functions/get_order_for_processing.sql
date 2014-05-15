DROP FUNCTION IF EXISTS get_order_for_processing ();
DROP FUNCTION IF EXISTS get_order_for_processing (
    i_order_id  BIGINT
  , i_user_id   BIGINT
);
CREATE OR REPLACE FUNCTION get_order_for_processing (
    i_order_id  BIGINT
  , i_user_id   BIGINT
)
RETURNS SETOF transaction.t_order
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order;
    BEGIN
        v_sql := '
            SELECT 
                 o.order_id             AS order_id
                ,o.insert_ts            AS insert_ts
                ,o.user_id              AS user_id
                ,o.transaction_id       AS transaction_id
                ,o.order_number         AS order_number
                ,o.order_status_id      AS order_status_id
                ,o.order_status_name    AS order_status_name
                ,o.shipping_cost        AS shipping_cost
                ,o.ship_to              AS ship_to
                ,o.bill_to              AS bill_to
                ,1                      AS total
            FROM transaction.v_order o
            WHERE o.order_status_id = 1
            AND order_id NOT IN
                (SELECT record_id FROM application.record_lock WHERE table_name = ''transaction.order''
                    AND (SELECT NOW()) - insert_ts < ''24 hours''::interval AND user_id != ' || i_user_id ||') 
            '|| COALESCE(' AND o.order_id = '||i_order_id, '') ||'
            LIMIT 1';
        --If any record has been in the record lock table for awhile, grab it too. Thats the insert_ts < 24 hours part
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_id                   := REC.order_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.user_id                    := REC.user_id;
            v_return.transaction_id             := REC.transaction_id;
            v_return.order_number               := REC.order_number;
            v_return.order_status_id            := REC.order_status_id;
            v_return.order_status_name          := REC.order_status_name;
            v_return.shipping_cost              := REC.shipping_cost;
            v_return.ship_to                    := REC.ship_to;
            v_return.bill_to                    := REC.bill_to;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
