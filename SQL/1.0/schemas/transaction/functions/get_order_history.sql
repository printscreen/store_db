DROP FUNCTION IF EXISTS get_order_history (
    i_order_history_id  BIGINT
  , i_order_id          BIGINT
  , i_history_type_id   BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_order_history (
    i_order_history_id  BIGINT
  , i_order_id          BIGINT
  , i_history_type_id   BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_order_history
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_history;
    BEGIN
        v_sql := '
            SELECT 
                  oh.order_history_id           AS order_history_id
                , oh.order_id                   AS order_id
                , oh.insert_ts                  AS insert_ts
                , oh.description                AS description
                , oh.user_id                    AS user_id
                , oh.first_name                 AS first_name
                , oh.last_name                  AS last_name
                , oh.order_history_type_id      AS order_history_type_id
                , oh.order_history_type_name    AS order_history_type_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_order_history oh 
                         WHERE true '||COALESCE(' AND oh.order_history_id='||i_order_history_id, '')||
                                       COALESCE(' AND oh.order_id='||i_order_id, '')||
                                       COALESCE(' AND oh.order_history_type_id='||i_history_type_id, '')||
                       ')::BIGINT       AS total
            FROM transaction.v_order_history oh
            WHERE TRUE'
            || COALESCE(' AND oh.order_history_id='||i_order_history_id, '')||
               COALESCE(' AND oh.order_id='||i_order_id, '')||
               COALESCE(' AND oh.order_history_type_id='||i_history_type_id, '')|| 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_history_id           := REC.order_history_id;
            v_return.order_id                   := REC.order_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.description                := REC.description;
            v_return.user_id                    := REC.user_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.order_history_type_id      := REC.order_history_type_id;
            v_return.order_history_type_name    := REC.order_history_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;   


DROP FUNCTION IF EXISTS get_order_history (
    i_order_history_id  BIGINT
);

CREATE OR REPLACE FUNCTION get_order_history (
    i_order_history_id  BIGINT
)
RETURNS SETOF transaction.t_order_history
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_history;
    BEGIN
        v_sql := '
            SELECT 
                  oh.order_history_id           AS order_history_id
                , oh.order_id                   AS order_id
                , oh.insert_ts                  AS insert_ts
                , oh.description                AS description
                , oh.user_id                    AS user_id
                , oh.first_name                 AS first_name
                , oh.last_name                  AS last_name
                , oh.order_history_type_id      AS order_history_type_id
                , oh.order_history_type_name    AS order_history_type_name
                , 1                             AS total
            FROM transaction.v_order_history oh
            WHERE oh.order_history_id='||i_order_history_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_history_id           := REC.order_history_id;
            v_return.order_id                   := REC.order_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.description                := REC.description;
            v_return.user_id                    := REC.user_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.order_history_type_id      := REC.order_history_type_id;
            v_return.order_history_type_name    := REC.order_history_type_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;   
