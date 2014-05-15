DROP FUNCTION IF EXISTS get_postage_package_type (
    i_postage_package_type_id   BIGINT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
);

CREATE OR REPLACE FUNCTION get_postage_package_type (
    i_postage_package_type_id   BIGINT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
)
RETURNS SETOF transaction.t_postage_package_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_postage_package_type;
    BEGIN
        v_sql := '

            SELECT 
                 pt.postage_package_type_id     AS postage_package_type_id
                ,pt.postage_package_type_name   AS postage_package_type_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_postage_package_type pt WHERE true '||COALESCE(' AND pt.postage_package_type_id='||i_postage_package_type_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_postage_package_type pt
            WHERE TRUE'
            || COALESCE(' AND pt.postage_package_type_id='||i_postage_package_type_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.postage_package_type_id    := REC.postage_package_type_id;
            v_return.postage_package_type_name  := REC.postage_package_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;


DROP FUNCTION IF EXISTS get_postage_package_type (
    i_postage_package_type_id   BIGINT
);

CREATE OR REPLACE FUNCTION get_postage_package_type (
    i_postage_package_type_id   BIGINT
)
RETURNS SETOF transaction.t_postage_package_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_postage_package_type;
    BEGIN
        v_sql := '

            SELECT 
                 pt.postage_package_type_id     AS postage_package_type_id
                ,pt.postage_package_type_name   AS postage_package_type_name
                ,1                              AS total
            FROM transaction.v_postage_package_type pt
            WHERE pt.postage_package_type_id='||i_postage_package_type_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.postage_package_type_id    := REC.postage_package_type_id;
            v_return.postage_package_type_name  := REC.postage_package_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

