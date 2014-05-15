DROP FUNCTION IF EXISTS get_item_ordered (
    i_item_ordered_id   BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_item_ordered (
    i_item_ordered_id   BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_item_ordered
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_item_ordered;
    BEGIN
        v_sql := '
            SELECT 
                 o.item_ordered_id      AS item_ordered_id
                ,o.insert_ts            AS insert_ts
                ,o.update_ts            AS update_ts
                ,o.item_id              AS item_id
                ,o.item_code            AS item_code
                ,o.item_name            AS item_name
                ,o.description          AS description
                ,o.order_id             AS order_id
                ,o.quantity             AS quantity
                ,o.active               AS active
                ,( SELECT COUNT(*)
                         FROM transaction.v_item_ordered o WHERE true '||COALESCE(' AND o.item_ordered_id='||i_item_ordered_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_item_ordered o
            WHERE TRUE'
            || COALESCE(' AND o.item_ordered_id='||i_item_ordered_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_ordered_id            := REC.item_ordered_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.item_id                    := REC.item_id;
            v_return.item_code                  := REC.item_code;
            v_return.item_name                  := REC.item_name;
            v_return.description                := REC.description;
            v_return.order_id                   := REC.order_id;
            v_return.quantity                   := REC.quantity;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_item_ordered (
    i_item_ordered_id   BIGINT
);

CREATE OR REPLACE FUNCTION get_item_ordered (
    i_item_ordered_id   BIGINT
)
RETURNS SETOF transaction.t_item_ordered
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_item_ordered;
    BEGIN
	    IF i_item_ordered_id IS NULL THEN
	       RETURN;
	    END IF;
        v_sql := '
            SELECT 
                 o.item_ordered_id      AS item_ordered_id
                ,o.insert_ts            AS insert_ts
                ,o.update_ts            AS update_ts
                ,o.item_id              AS item_id
                ,o.item_code            AS item_code
                ,o.item_name            AS item_name
                ,o.description          AS description
                ,o.order_id             AS order_id
                ,o.quantity             AS quantity
                ,o.active               AS active
                ,1                      AS total
            FROM transaction.v_item_ordered o
            WHERE o.item_ordered_id='||i_item_ordered_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_ordered_id            := REC.item_ordered_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.item_id                    := REC.item_id;
            v_return.item_code                  := REC.item_code;
            v_return.item_name                  := REC.item_name;
            v_return.description                := REC.description;
            v_return.order_id                   := REC.order_id;
            v_return.quantity                   := REC.quantity;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

