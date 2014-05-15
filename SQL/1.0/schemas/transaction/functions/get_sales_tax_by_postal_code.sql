DROP FUNCTION IF EXISTS get_sales_tax_by_postal_code (
    i_postal_code       VARCHAR
  , i_country_id        BIGINT
);

CREATE OR REPLACE FUNCTION get_sales_tax_by_postal_code (
    i_postal_code       VARCHAR
  , i_country_id        BIGINT
)
RETURNS SETOF transaction.t_sales_tax
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_sales_tax;
    BEGIN
	    IF i_postal_code IS NULL OR i_country_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 s.sales_tax_id     AS sales_tax_id
                ,s.insert_ts        AS insert_ts
                ,s.update_ts        AS update_ts
                ,s.postal_code      AS postal_code
                ,s.city             AS city
                ,s.state            AS state
                ,s.country_id       AS country_id
                ,s.tax_rate         AS tax_rate
                ,1                  AS total
            FROM transaction.v_sales_tax s
            WHERE s.postal_code='||quote_literal(i_postal_code) ||
            ' AND s.country_id='||i_country_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sales_tax_id               := REC.sales_tax_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.postal_code                := REC.postal_code;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.country_id                 := REC.country_id;
            v_return.tax_rate                   := REC.tax_rate;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
