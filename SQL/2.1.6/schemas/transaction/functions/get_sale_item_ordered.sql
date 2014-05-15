DROP FUNCTION IF EXISTS get_sale_item_ordered (
    i_start_date        TIMESTAMPTZ
  , i_end_date          TIMESTAMPTZ
);
CREATE OR REPLACE FUNCTION get_sale_item_ordered (
    i_start_date        TIMESTAMPTZ
  , i_end_date          TIMESTAMPTZ
)
RETURNS SETOF transaction.t_sale_item_ordered
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_sale_item_ordered;
    BEGIN

        v_sql := '
            SELECT
                 sio.sale_item_ordered_id AS sale_item_ordered_id
                ,sio.insert_ts            AS insert_ts
                ,sio.update_ts            AS update_ts
                ,sio.sale_item_id         AS sale_item_id
                ,sio.sale_item_name       AS sale_item_name
                ,sio.price_paid           AS price_paid
                ,sio.description          AS description
                ,sio.order_id             AS order_id
                ,sio.quantity             AS quantity
                ,sio.active               AS active
                ,( SELECT COUNT(*)
                         FROM transaction.v_sale_item_ordered sio
                         INNER JOIN transaction.order o ON sio.order_id = o.order_id
                         WHERE TRUE '
                         ||COALESCE(' AND o.insert_ts > '||quote_literal(i_start_date), '')
                         ||COALESCE(' AND o.insert_ts < '||quote_literal(i_end_date), '')
                         ||'
                       )::BIGINT       AS total
            FROM transaction.v_sale_item_ordered sio
            INNER JOIN transaction.order o ON sio.order_id = o.order_id
            WHERE TRUE '
            ||COALESCE(' AND o.insert_ts > '||quote_literal(i_start_date), '')
            ||COALESCE(' AND o.insert_ts < '||quote_literal(i_end_date), '')
            || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_ordered_id       := REC.sale_item_ordered_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_item_name             := REC.sale_item_name;
            v_return.price_paid                 := REC.price_paid;
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