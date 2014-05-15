DROP FUNCTION IF EXISTS get_sale_items_items_total_weight (
    i_sale_item_ids     BIGINT[]
);
CREATE OR REPLACE FUNCTION get_sale_items_items_total_weight (
    i_sale_item_ids     BIGINT[]
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        weight BIGINT;
    BEGIN
	    weight = 0;
        FOR REC IN SELECT i.weight_ounces AS weight, sii.quantity AS quantity FROM inventory.sale_item_item sii 
            INNER JOIN inventory.item i ON sii.item_id = i.item_id 
            WHERE i.item_type_id = 1 
            AND sii.sale_item_id = ANY(i_sale_item_ids) LOOP
            weight = weight + (REC.weight * REC.quantity);    
        END LOOP;
        
        RETURN weight;
    END;
$_$
LANGUAGE PLPGSQL;