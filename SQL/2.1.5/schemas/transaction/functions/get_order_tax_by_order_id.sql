DROP FUNCTION IF EXISTS get_order_tax_by_order_id (
    i_order_id BIGINT
);

CREATE OR REPLACE FUNCTION get_order_tax_by_order_id (
    i_order_id BIGINT
)
RETURNS SETOF transaction.t_order_tax
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_tax;
    BEGIN
        IF i_order_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT
                 ot.order_tax_id        AS order_tax_id
                ,ot.order_id            AS order_id
                ,ot.tax_id              AS tax_id
                ,ot.rate                AS rate
                ,ot.insert_ts           AS insert_ts
                ,1                      AS total
            FROM transaction.v_order_tax ot
            WHERE ot.order_tax_id='||i_order_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_tax_id               := REC.order_tax_id;
            v_return.order_id                   := REC.order_id;
            v_return.tax_id                     := REC.tax_id;
            v_return.rate                       := REC.rate;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;