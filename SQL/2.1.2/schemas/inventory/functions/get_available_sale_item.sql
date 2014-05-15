DROP FUNCTION IF EXISTS get_available_sale_item (
    i_order_id          BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_available_sale_item (
    i_order_id          BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item;
    BEGIN
	    IF i_order_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 si.sale_item_id    AS sale_item_id
                ,si.name            AS name
                ,si.description     AS description
                ,si.price           AS price
                ,si.insert_ts       AS insert_ts
                ,si.active          AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_item si
                         WHERE sale_item_id NOT IN (SELECT sale_item_id FROM transaction.sale_item_ordered sio WHERE sio.active AND sio.order_id = '|| i_order_id ||')
                         AND si.active
                       )::BIGINT   AS total
            FROM inventory.v_sale_item si
            WHERE sale_item_id NOT IN (SELECT sale_item_id FROM transaction.sale_item_ordered sio WHERE sio.active AND sio.order_id = '|| i_order_id ||')
            AND si.active
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';
    
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_id       := REC.sale_item_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.price              := REC.price;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
      
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;