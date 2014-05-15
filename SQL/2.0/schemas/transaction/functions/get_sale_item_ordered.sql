DROP FUNCTION IF EXISTS get_item_ordered (
    i_item_ordered_id   BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
DROP FUNCTION IF EXISTS get_item_ordered_by_order_id (
    i_order_id          BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
DROP FUNCTION IF EXISTS get_item_ordered (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
DROP FUNCTION IF EXISTS get_sale_item_ordered (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_item_ordered (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
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
                 o.sale_item_ordered_id AS sale_item_ordered_id
                ,o.insert_ts            AS insert_ts
                ,o.update_ts            AS update_ts
                ,o.sale_item_id         AS sale_item_id
                ,o.sale_item_name       AS sale_item_name
                ,o.price_paid           AS price_paid
                ,o.description          AS description
                ,o.order_id             AS order_id
                ,o.quantity             AS quantity
                ,o.active               AS active
                ,( SELECT COUNT(*)
                         FROM transaction.v_sale_item_ordered o
                       )::BIGINT       AS total
            FROM transaction.v_sale_item_ordered o
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_ordered_id       := REC.sale_item_ordered_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_item_name             := REC.sale_item_name;
            v_return.description                := REC.description;
            v_return.price_paid                 := REC.price_paid;
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
DROP FUNCTION IF EXISTS get_sale_item_ordered (
    i_sale_item_ordered_id   BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_item_ordered (
    i_sale_item_ordered_id   BIGINT
)
RETURNS SETOF transaction.t_sale_item_ordered
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_sale_item_ordered;
    BEGIN
        IF i_sale_item_ordered_id IS NULL THEN
           RETURN;
        END IF;
        v_sql := '
            SELECT 
                 o.sale_item_ordered_id AS sale_item_ordered_id
                ,o.insert_ts            AS insert_ts
                ,o.update_ts            AS update_ts
                ,o.sale_item_id         AS sale_item_id
                ,o.sale_item_name       AS sale_item_name
                ,o.price_paid           AS price_paid
                ,o.description          AS description
                ,o.order_id             AS order_id
                ,o.quantity             AS quantity
                ,o.active               AS active
                ,1                      AS total
            FROM transaction.v_sale_item_ordered o
            WHERE o.sale_item_ordered_id='||i_sale_item_ordered_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_ordered_id       := REC.sale_item_ordered_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_item_name             := REC.sale_item_name;
            v_return.description                := REC.description;
            v_return.price_paid                 := REC.price_paid;
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
    i_order_id          BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

DROP FUNCTION IF EXISTS get_sale_item_ordered (
    i_order_id          BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);

CREATE OR REPLACE FUNCTION get_sale_item_ordered (
    i_order_id          BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_sale_item_ordered
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_sale_item_ordered;
    BEGIN
        IF i_order_id IS NULL THEN
           RETURN;
        END IF;
        v_sql := '
            SELECT 
                 o.sale_item_ordered_id AS sale_item_ordered_id
                ,o.insert_ts            AS insert_ts
                ,o.update_ts            AS update_ts
                ,o.sale_item_id         AS sale_item_id
                ,o.sale_item_name       AS sale_item_name
                ,o.price_paid           AS price_paid
                ,o.description          AS description
                ,o.order_id             AS order_id
                ,o.quantity             AS quantity
                ,o.active               AS active
                ,( SELECT COUNT(*)
                         FROM transaction.v_sale_item_ordered o WHERE true '||COALESCE(' AND o.order_id='||i_order_id, '')||'
                       )::BIGINT       AS total
            FROM transaction.v_sale_item_ordered o
            WHERE TRUE'
            || COALESCE(' AND o.order_id='||i_order_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

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