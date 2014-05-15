DROP FUNCTION IF EXISTS get_postage_service_type (
    i_postage_service_type_id   BIGINT
  , i_carrier_id                BIGINT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
);

CREATE OR REPLACE FUNCTION get_postage_service_type (
    i_postage_service_type_id   BIGINT
  , i_carrier_id                BIGINT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
)
RETURNS SETOF transaction.t_postage_service_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_postage_service_type;
    BEGIN
        v_sql := '

            SELECT 
                 st.postage_service_type_id     AS postage_service_type_id
                ,st.postage_service_type_name   AS postage_service_type_name
                ,st.code                        AS code
                ,st.carrier_id                  AS carrier_id
                ,st.carrier_name                AS carrier_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_postage_service_type st WHERE true '
                        ||COALESCE(' AND st.postage_service_type_id='||i_postage_service_type_id, '')||
                          COALESCE(' AND st.carrier_id='||i_carrier_id, '')||
                       ')::BIGINT       AS total
            FROM transaction.v_postage_service_type st
            WHERE TRUE'
            || COALESCE(' AND st.postage_service_type_id='||i_postage_service_type_id, '') ||
               COALESCE(' AND st.carrier_id='||i_carrier_id, '')||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.postage_service_type_id    := REC.postage_service_type_id;
            v_return.postage_service_type_name  := REC.postage_service_type_name;
            v_return.code                       := REC.code;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;


DROP FUNCTION IF EXISTS get_postage_service_type (
    i_postage_service_type_id   BIGINT
);

CREATE OR REPLACE FUNCTION get_postage_service_type (
    i_postage_service_type_id   BIGINT
)
RETURNS SETOF transaction.t_postage_service_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_postage_service_type;
    BEGIN
        v_sql := '

            SELECT 
                 st.postage_service_type_id     AS postage_service_type_id
                ,st.postage_service_type_name   AS postage_service_type_name
                ,st.code                        AS code
                ,st.carrier_id                  AS carrier_id
                ,st.carrier_name                AS carrier_name
                ,1                              AS total
            FROM transaction.v_postage_service_type st
            WHERE st.postage_service_type_id='||i_postage_service_type_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.postage_service_type_id    := REC.postage_service_type_id;
            v_return.postage_service_type_name  := REC.postage_service_type_name;
            v_return.code                       := REC.code;
            v_return.carrier_id                 := REC.carrier_id;
            v_return.carrier_name               := REC.carrier_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

