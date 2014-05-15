DROP FUNCTION IF EXISTS get_pledge_source (
    i_pledge_source_id  BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_pledge_source (
    i_pledge_source_id  BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_pledge_source
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_pledge_source;
    BEGIN
        v_sql := '
            SELECT 
                 ps.pledge_source_id       AS pledge_source_id
                ,ps.pledge_source_name     AS pledge_source_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_pledge_source ps WHERE true '||COALESCE(' AND ps.pledge_source_id='||i_pledge_source_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_pledge_source ps
            WHERE TRUE'
            ||COALESCE(' AND ps.pledge_source_id='||i_pledge_source_id, '')|| 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.pledge_source_id           := REC.pledge_source_id;
            v_return.pledge_source_name         := REC.pledge_source_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_pledge_source (
    i_pledge_source_id  BIGINT
);

CREATE OR REPLACE FUNCTION get_pledge_source (
    i_pledge_source_id  BIGINT
)
RETURNS SETOF transaction.t_pledge_source
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_pledge_source;
    BEGIN
        IF i_pledge_source_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 ps.pledge_source_id       AS pledge_source_id
                ,ps.pledge_source_name     AS pledge_source_name
                ,1                         AS total
            FROM transaction.v_pledge_source ps
            WHERE ps.pledge_source_id='||i_pledge_source_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.pledge_source_id           := REC.pledge_source_id;
            v_return.pledge_source_name         := REC.pledge_source_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
