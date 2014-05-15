DROP FUNCTION IF EXISTS get_tax_by_postal_code (
    i_postal_code BIGINT
);

CREATE OR REPLACE FUNCTION get_tax_by_postal_code (
    i_postal_code BIGINT
)
RETURNS SETOF transaction.t_tax
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_tax;
    BEGIN
        IF i_postal_code IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 t.tax_id               AS tax_id
                ,t.postal_code          AS postal_code
                ,t.rate                 AS rate
                ,t.active               AS active
                ,t.update_ts            AS update_ts
                ,t.insert_ts            AS insert_ts
                ,1                      AS total
            FROM transaction.v_tax t
            WHERE t.postal_code='||i_postal_code || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.tax_id                     := REC.tax_id;
            v_return.postal_code                := REC.postal_code;
            v_return.rate                       := REC.rate;
            v_return.active                     := REC.active;
            v_return.update_ts                  := REC.update_ts;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;