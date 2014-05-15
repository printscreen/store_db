DROP FUNCTION IF EXISTS get_order_postage (
     i_order_postage_id  BIGINT
   , i_order_id          BIGINT
);

CREATE OR REPLACE FUNCTION get_order_postage (
     i_order_postage_id  BIGINT
   , i_order_id          BIGINT
)
RETURNS SETOF transaction.t_order_postage
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_postage;
    BEGIN
        IF i_order_postage_id IS NULL AND i_order_id IS NULL THEN
           return;
        END IF;
        
        v_sql := '
            SELECT 
                 op.order_postage_id            AS order_postage_id
                ,op.order_id                    AS order_id
                ,op.insert_ts                   AS insert_ts
                ,op.carrier_id                  AS carrier_id
                ,op.carrier_name                AS carrier_name
                ,op.tracking_number             AS tracking_number
                ,op.stamps_id                   AS stamps_id
                ,op.postage_service_type_id     AS postage_service_type_id
                ,op.postage_service_type_name   AS postage_service_type_name
                ,op.postage_service_type_code   AS postage_service_type_code
                ,op.postage_package_type_id     AS postage_package_type_id
                ,op.postage_package_type_name   AS postage_package_type_name
                ,op.ship_date                   AS ship_date
                ,op.weight                      AS weight
                ,op.amount                      AS amount
            FROM transaction.v_order_postage op
            WHERE TRUE'
            || COALESCE(' AND op.order_postage_id='||i_order_postage_id, '') || 
               COALESCE(' AND op.order_id='||i_order_id, '') || ';';
               
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_postage_id           := REC.order_postage_id;
            v_return.order_id                   := REC.order_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.tracking_number            := REC.tracking_number;
            v_return.stamps_id                  := REC.stamps_id;
            v_return.postage_service_type_id    := REC.postage_service_type_id;
            v_return.postage_service_type_name  := REC.postage_service_type_name;
            v_return.postage_service_type_code  := REC.postage_service_type_code;
            v_return.postage_package_type_id    := REC.postage_package_type_id;
            v_return.postage_package_type_name  := REC.postage_package_type_name;
            v_return.ship_date                  := REC.ship_date;
            v_return.weight                     := REC.weight;
            v_return.amount                     := REC.amount;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
