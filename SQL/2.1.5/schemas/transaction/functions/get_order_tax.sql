DROP FUNCTION IF EXISTS get_tax (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_tax (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_order_tax
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_tax;
    BEGIN
        v_sql := '
            SELECT 
                 ot.order_tax_id        AS order_tax_id
                ,ot.order_id            AS order_id
                ,ot.tax_id              AS tax_id
                ,ot.rate                AS rate
                ,ot.insert_ts           AS insert_ts
                ,( SELECT COUNT(*)
                         FROM transaction.v_order_tax ot
                       )::BIGINT       AS total
            FROM transaction.v_order_tax ot
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

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

DROP FUNCTION IF EXISTS get_order_tax (
    i_order_tax_id BIGINT
);

CREATE OR REPLACE FUNCTION get_order_tax (
    i_order_tax_id BIGINT
)
RETURNS SETOF transaction.t_order_tax
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_tax;
    BEGIN
        IF i_order_tax_id IS NULL THEN
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
            WHERE ot.order_tax_id='||i_order_tax_id || ';';

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