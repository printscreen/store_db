DROP FUNCTION IF EXISTS get_order_shipping (
     i_order_shipping_id BIGINT
   , i_order_id          BIGINT
);

CREATE OR REPLACE FUNCTION get_order_shipping (
      i_order_shipping_id     BIGINT
    , i_order_id              BIGINT
)
RETURNS SETOF transaction.t_order_shipping
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_shipping;
    BEGIN
        v_sql := '
            SELECT 
                 o.order_shipping_id    AS order_shipping_id
                ,o.shipping_insert_ts   AS shipping_insert_ts
                ,o.shipping_update_ts   AS shipping_update_ts
                ,o.shipping_first_name  AS shipping_first_name
                ,o.shipping_last_name   AS shipping_last_name
                ,o.order_id             AS order_id
                ,o.shipping_cost        AS shipping_cost
                ,o.address_id           AS address_id
                ,o.address_insert_ts    AS address_insert_ts
                ,o.address_update_ts    AS address_update_ts
                ,o.street               AS street
                ,o.unit_number          AS unit_number
                ,o.city                 AS city
                ,o.state                AS state
                ,o.postal_code          AS postal_code
                ,o.country_id           AS country_id
                ,o.country_name         AS country_name
                ,o.country_code         AS country_code
                ,o.user_id              AS user_id
                ,o.user_first_name      AS user_first_name
                ,o.user_last_name       AS user_last_name
                ,o.active               AS active
            FROM transaction.v_order_shipping o
            WHERE TRUE'
            || COALESCE(' AND o.order_shipping_id='||i_order_shipping_id, '') || 
               COALESCE(' AND o.order_id='||i_order_id, '') || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_shipping_id          := REC.order_shipping_id;
            v_return.shipping_insert_ts         := REC.shipping_insert_ts;
            v_return.shipping_update_ts         := REC.shipping_update_ts;
            v_return.shipping_first_name        := REC.shipping_first_name;
            v_return.shipping_last_name         := REC.shipping_last_name;
            v_return.order_id                   := REC.order_id;
            v_return.shipping_cost              := REC.shipping_cost;
            v_return.address_id                 := REC.address_id;
            v_return.address_insert_ts          := REC.address_insert_ts;
            v_return.address_update_ts          := REC.address_update_ts;
            v_return.street                     := REC.street;
            v_return.unit_number                := REC.unit_number;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.postal_code                := REC.postal_code;
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.user_id                    := REC.user_id;
            v_return.user_first_name            := REC.user_first_name;
            v_return.user_last_name             := REC.user_last_name;
            v_return.active                     := REC.active;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
