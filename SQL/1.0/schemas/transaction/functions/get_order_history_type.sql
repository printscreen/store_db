DROP FUNCTION IF EXISTS get_order_history_type (
    i_order_history_type_id BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);

CREATE OR REPLACE FUNCTION get_order_history_type (
    i_order_history_type_id BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF transaction.t_order_history_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_history_type;
    BEGIN
        v_sql := '

            SELECT 
                 ht.order_history_type_id    AS order_history_type_id
                ,ht.order_history_type_name  AS order_history_type_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_order_history_type ht WHERE true '||COALESCE(' AND ht.order_history_type_id='||i_order_history_type_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_order_history_type ht
            WHERE TRUE'
            || COALESCE(' AND ht.order_history_type_id='||i_order_history_type_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_history_type_id      := REC.order_history_type_id;
            v_return.order_history_type_name    := REC.order_history_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;


DROP FUNCTION IF EXISTS get_order_history_type (
    i_order_history_type_id BIGINT
);

CREATE OR REPLACE FUNCTION get_order_history_type (
    i_order_history_type_id BIGINT
)
RETURNS SETOF transaction.t_order_history_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_history_type;
    BEGIN
        v_sql := '

            SELECT 
                 ht.order_history_type_id    AS order_history_type_id
                ,ht.order_history_type_name  AS order_history_type_name
                ,1                           AS total
            FROM transaction.v_order_history_type ht
            WHERE ht.order_history_type_id='||i_order_history_type_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_history_type_id      := REC.order_history_type_id;
            v_return.order_history_type_name    := REC.order_history_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
