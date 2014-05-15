DROP FUNCTION IF EXISTS get_paypal (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_paypal (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_paypal
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_paypal;
    BEGIN
        v_sql := '
            SELECT 
                 p.paypal_id            AS paypal_id
                ,p.insert_ts            AS insert_ts
                ,p.user_id              AS user_id
                ,p.email                AS email
                ,p.order_status_id      AS order_status_id
                ,p.order_status_name    AS order_status_name
                ,p.shipping_cost        AS shipping_cost
                ,p.ship_to              AS ship_to
                ,p.bill_to              AS bill_to
                ,p.cart                 AS cart
                ,p.token                AS token
                ,( SELECT COUNT(*)
                         FROM transaction.v_paypal
                       )::BIGINT       AS total
            FROM transaction.v_paypal p
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.paypal_id                  := REC.paypal_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.user_id                    := REC.user_id;
            v_return.email                      := REC.email;
            v_return.order_status_id            := REC.order_status_id;
            v_return.order_status_name          := REC.order_status_name;
            v_return.shipping_cost              := REC.shipping_cost;
            v_return.ship_to                    := REC.ship_to;
            v_return.bill_to                    := REC.bill_to;
            v_return.token                      := REC.token;
            v_return.cart                       := REC.cart;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_paypal (
    i_paypal_id BIGINT
);

CREATE OR REPLACE FUNCTION get_paypal (
    i_paypal_id BIGINT
)
RETURNS SETOF transaction.t_paypal
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_paypal;
    BEGIN
        IF i_paypal_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 p.paypal_id            AS paypal_id
                ,p.insert_ts            AS insert_ts
                ,p.user_id              AS user_id
                ,p.email                AS email
                ,p.order_status_id      AS order_status_id
                ,p.order_status_name    AS order_status_name
                ,p.shipping_cost        AS shipping_cost
                ,p.ship_to              AS ship_to
                ,p.bill_to              AS bill_to
                ,p.token                AS token
                ,p.cart                 AS cart
                ,1                      AS total
            FROM transaction.v_paypal p
            WHERE p.paypal_id='||i_paypal_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.paypal_id                  := REC.paypal_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.user_id                    := REC.user_id;
            v_return.email                      := REC.email;
            v_return.order_status_id            := REC.order_status_id;
            v_return.order_status_name          := REC.order_status_name;
            v_return.shipping_cost              := REC.shipping_cost;
            v_return.ship_to                    := REC.ship_to;
            v_return.bill_to                    := REC.bill_to;
            v_return.token                      := REC.token;
            v_return.cart                       := REC.cart;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_paypal (
    i_token VARCHAR(255)
);

CREATE OR REPLACE FUNCTION get_paypal (
    i_token VARCHAR(255)
)
RETURNS SETOF transaction.t_paypal
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_paypal;
    BEGIN
        IF i_token IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 p.paypal_id            AS paypal_id
                ,p.insert_ts            AS insert_ts
                ,p.user_id              AS user_id
                ,p.email                AS email
                ,p.order_status_id      AS order_status_id
                ,p.order_status_name    AS order_status_name
                ,p.shipping_cost        AS shipping_cost
                ,p.ship_to              AS ship_to
                ,p.bill_to              AS bill_to
                ,p.token                AS token
                ,p.cart                 AS cart
                ,1                      AS total
            FROM transaction.v_paypal p
            WHERE p.token='||quote_literal(i_token) || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.paypal_id                  := REC.paypal_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.user_id                    := REC.user_id;
            v_return.email                      := REC.email;
            v_return.order_status_id            := REC.order_status_id;
            v_return.order_status_name          := REC.order_status_name;
            v_return.shipping_cost              := REC.shipping_cost;
            v_return.ship_to                    := REC.ship_to;
            v_return.bill_to                    := REC.bill_to;
            v_return.token                      := REC.token;
            v_return.cart                       := REC.cart;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

