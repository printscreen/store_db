DROP FUNCTION IF EXISTS delete_sale_group_picture (
    i_sale_group_picture_id   BIGINT
);
CREATE OR REPLACE FUNCTION delete_sale_group_picture (
    i_sale_group_picture_id   BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_group_picture;
        v_find_primary inventory.sale_group_picture;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_group_picture WHERE sale_group_picture_id = i_sale_group_picture_id;
        IF v_old.sale_group_picture_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM inventory.sale_group_picture WHERE sale_group_picture_id = i_sale_group_picture_id;
        
        --If this was the primary picture, move it to another
        IF v_old.primary_picture IS TRUE THEN
	        SELECT * INTO v_find_primary FROM inventory.sale_group_picture WHERE sale_group_id = v_old.sale_group_id LIMIT 1;
	        IF v_find_primary.sale_group_picture_id IS NOT NULL THEN
	            UPDATE inventory.sale_group_picture SET primary_picture = true WHERE sale_group_picture_id = v_find_primary.sale_group_picture_id;
	        END IF;
        END IF;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
