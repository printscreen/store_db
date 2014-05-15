DROP FUNCTION IF EXISTS get_country (
    i_country_id        BIGINT
  , i_active            BOOLEAN
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_country (
    i_country_id        BIGINT
  , i_active            BOOLEAN  
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_country
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_country;
    BEGIN
        v_sql := '
            SELECT 
                 c.country_id              AS country_id
                ,c.country_name            AS country_name
                ,c.country_code            AS country_code
                ,c.active                  AS active
                ,( SELECT COUNT(*)
                         FROM transaction.v_country c WHERE true '||COALESCE(' AND c.country_id='||i_country_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_country c
            WHERE TRUE'
            || COALESCE(' AND c.country_id='||i_country_id, '') ||
               COALESCE(' AND c.active='||i_active, '') ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_country (
    i_country_id        BIGINT
);

CREATE OR REPLACE FUNCTION get_country (
    i_country_id        BIGINT
)
RETURNS SETOF transaction.t_country
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_country;
    BEGIN
	    IF i_country_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 c.country_id              AS country_id
                ,c.country_name            AS country_name
                ,c.country_code            AS country_code
                ,c.active                  AS active
                ,1                         AS total
            FROM transaction.v_country c
            WHERE c.country_id='||i_country_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

