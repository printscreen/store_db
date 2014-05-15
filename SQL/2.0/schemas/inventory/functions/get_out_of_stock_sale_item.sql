DROP FUNCTION IF EXISTS get_out_of_stock_sale_item (
    i_sale_item_ids     BIGINT[]
);
CREATE OR REPLACE FUNCTION get_out_of_stock_sale_item (
    i_sale_item_ids     BIGINT[]
)
RETURNS SETOF inventory.t_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item;
    BEGIN
        v_sql := '
            SELECT 
                 si.sale_item_id    AS sale_item_id
                ,si.name            AS name
                ,si.description     AS description
                ,si.price           AS price
                ,si.insert_ts       AS insert_ts
                ,si.active          AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_get_out_of_stock_sale_item si
                         WHERE TRUE
                         AND sale_item_id IN ('|| array_to_string(i_sale_item_ids,',') || ')
                       )::BIGINT   AS total
            FROM inventory.v_get_out_of_stock_sale_item  si
            WHERE TRUE
            AND sale_item_id IN ('|| array_to_string(i_sale_item_ids,',') || ');';
    
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