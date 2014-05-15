DROP FUNCTION IF EXISTS get_carrier (
    i_carrier_id        BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_carrier (
    i_carrier_id        BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_carrier
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_carrier;
    BEGIN
        v_sql := '
            SELECT 
                 c.carrier_id              AS carrier_id
                ,c.carrier_name            AS carrier_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_carrier c WHERE true '||COALESCE(' AND c.carrier_id='||i_carrier_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_carrier c
            WHERE TRUE'
            || COALESCE(' AND c.carrier_id='||i_carrier_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_carrier (
    i_carrier_id        BIGINT
);

CREATE OR REPLACE FUNCTION get_carrier (
    i_carrier_id        BIGINT
)
RETURNS SETOF transaction.t_carrier
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_carrier;
    BEGIN
	    IF i_carrier_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 c.carrier_id              AS carrier_id
                ,c.carrier_name            AS carrier_name
                ,1                         AS total
            FROM transaction.v_carrier c
            WHERE c.carrier_id='||i_carrier_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
