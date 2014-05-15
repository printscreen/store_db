DROP FUNCTION IF EXISTS get_carrier_addon (
    i_carrier_addon_id  BIGINT
  , i_carrier_id        BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_carrier_addon (
    i_carrier_addon_id  BIGINT
  , i_carrier_id        BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_carrier_addon
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_carrier_addon;
    BEGIN
        v_sql := '
            SELECT 
                  ca.carrier_addon_id   AS carrier_addon_id
                , ca.carrier_addon_name AS carrier_addon_name
                , ca.code               AS code
                , ca.carrier_id         AS carrier_id
                , ca.carrier_name       AS carrier_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_carrier_addon ca 
                         WHERE true '||COALESCE(' AND ca.carrier_addon_id='||i_carrier_addon_id, '')||
                                       COALESCE(' AND ca.carrier_id='||i_carrier_id, '')||
                       ')::BIGINT       AS total
            FROM transaction.v_carrier_addon ca
            WHERE TRUE'
            ||COALESCE(' AND ca.carrier_addon_id='||i_carrier_addon_id, '')||
              COALESCE(' AND ca.carrier_id='||i_carrier_id, '')|| 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.carrier_addon_id           := REC.carrier_addon_id;
            v_return.carrier_addon_name         := REC.carrier_addon_name;
            v_return.code                       := REC.code;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;   


DROP FUNCTION IF EXISTS get_carrier_addon (
    i_carrier_addon_id  BIGINT
);

CREATE OR REPLACE FUNCTION get_carrier_addon (
    i_carrier_addon_id  BIGINT
)
RETURNS SETOF transaction.t_carrier_addon
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_carrier_addon;
    BEGIN
        v_sql := '
            SELECT 
                  ca.carrier_addon_id   AS carrier_addon_id
                , ca.carrier_addon_name AS carrier_addon_name
                , ca.code               AS code
                , ca.carrier_id         AS carrier_id
                , ca.carrier_name       AS carrier_name
                , 1                     AS total
            FROM transaction.v_carrier_addon ca
            WHERE ca.carrier_addon_id='||i_carrier_addon_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.carrier_addon_id           := REC.carrier_addon_id;
            v_return.carrier_addon_name         := REC.carrier_addon_name;
            v_return.code                       := REC.code;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;   
