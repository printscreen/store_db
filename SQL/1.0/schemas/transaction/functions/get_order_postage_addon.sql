DROP FUNCTION IF EXISTS get_order_postage_addon (
    i_order_postage_addon_id    BIGINT
  , i_order_postage_id          BIGINT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
);

CREATE OR REPLACE FUNCTION get_order_postage_addon (
    i_order_postage_addon_id    BIGINT
  , i_order_postage_id          BIGINT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
)
RETURNS SETOF transaction.t_order_postage_addon
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_postage_addon;
    BEGIN
        v_sql := '
            SELECT 
                  opa.order_postage_addon_id    AS order_postage_addon_id    
                , opa.order_postage_id          AS order_postage_id
                , opa.order_id                  AS order_id
                , opa.carrier_addon_id          AS carrier_addon_id
                , opa.carrier_addon_name        AS carrier_addon_name
                , opa.carrier_id                AS carrier_id
                , opa.carrier_name              AS carrier_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_order_postage_addon opa 
                         WHERE true '||COALESCE(' AND opa.order_postage_addon_id='||i_order_postage_addon_id, '')||
                                       COALESCE(' AND opa.order_postage_id='||i_order_postage_id, '')||
                       ')::BIGINT       AS total
            FROM transaction.v_order_postage_addon opa
            WHERE TRUE'
            ||COALESCE(' AND opa.order_postage_addon_id='||i_order_postage_addon_id, '')||
              COALESCE(' AND opa.order_postage_id='||i_order_postage_id, '')||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_postage_addon_id     := REC.order_postage_addon_id;
            v_return.order_postage_id           := REC.order_postage_id;
            v_return.order_id                   := REC.order_id;
            v_return.carrier_addon_id           := REC.carrier_addon_id;
            v_return.carrier_addon_name         := REC.carrier_addon_name;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;   


DROP FUNCTION IF EXISTS get_order_postage_addon (
    i_order_postage_addon_id    BIGINT
);

CREATE OR REPLACE FUNCTION get_order_postage_addon (
    i_order_postage_addon_id    BIGINT
)
RETURNS SETOF transaction.t_order_postage_addon
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_postage_addon;
    BEGIN
        v_sql := '
            SELECT 
                  opa.order_postage_addon_id    AS order_postage_addon_id    
                , opa.order_postage_id          AS order_postage_id
                , opa.order_id                  AS order_id
                , opa.carrier_addon_id          AS carrier_addon_id
                , opa.carrier_addon_name        AS carrier_addon_name
                , opa.carrier_id                AS carrier_id
                , opa.carrier_name              AS carrier_name
                , 1                             AS total
            FROM transaction.v_order_postage_addon opa
            WHERE opa.order_postage_addon_id='||i_order_postage_addon_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_postage_addon_id     := REC.order_postage_addon_id;
            v_return.order_postage_id           := REC.order_postage_id;
            v_return.order_id                   := REC.order_id;
            v_return.carrier_addon_id           := REC.carrier_addon_id;
            v_return.carrier_addon_name         := REC.carrier_addon_name;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;   
