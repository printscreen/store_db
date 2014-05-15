DROP FUNCTION IF EXISTS set_sale_group_picture (
    i_sale_group_picture_id BIGINT
  , i_sale_group_id         BIGINT
  , i_file_path             VARCHAR(255)
  , i_thumbnail_path        VARCHAR(255)
  , i_alt_text              VARCHAR(255)
  , i_primary_picture       BOOLEAN
  , i_order_number          BIGINT
);
CREATE OR REPLACE FUNCTION set_sale_group_picture (
    i_sale_group_picture_id BIGINT
  , i_sale_group_id         BIGINT
  , i_file_path             VARCHAR(255)
  , i_thumbnail_path        VARCHAR(255)
  , i_alt_text              VARCHAR(255)
  , i_primary_picture       BOOLEAN
  , i_order_number          BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_group_picture;
        v_find_primary inventory.sale_group_picture;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_group_picture WHERE sale_group_picture_id = i_sale_group_picture_id;
        
        IF v_old.sale_group_picture_id IS NULL THEN
            --Is this the only photo in the group?
            SELECT * INTO v_find_primary FROM inventory.sale_group_picture WHERE sale_group_id = i_sale_group_id LIMIT 1;
            IF v_find_primary.sale_group_picture_id IS NULL THEN
                i_primary_picture = true;
            END IF;
        
            IF i_primary_picture IS TRUE THEN
                UPDATE inventory.sale_group_picture SET primary_picture = false WHERE sale_group_id = i_sale_group_id;
            END IF;
            INSERT INTO inventory.sale_group_picture (
                sale_group_id
              , file_path
              , thumbnail_path
              , alt_text
              , primary_picture
              , order_number
            ) VALUES (
                i_sale_group_id
              , i_file_path
              , i_thumbnail_path
              , i_alt_text
              , i_primary_picture
              , i_order_number
            );

            v_id := CURRVAL('inventory.sale_group_picture_sale_group_picture_id_seq');

        ELSE
            IF i_primary_picture IS TRUE THEN
                UPDATE inventory.sale_group_picture SET primary_picture = false WHERE sale_group_id = v_old.sale_group_id;
            END IF;
            UPDATE inventory.sale_group_picture SET
                sale_group_id = COALESCE(i_sale_group_id, sale_group_id)
              , file_path = COALESCE(i_file_path, file_path)
              , thumbnail_path = COALESCE(i_thumbnail_path, thumbnail_path)
              , alt_text = COALESCE(i_alt_text, alt_text)
              , primary_picture = COALESCE(i_primary_picture, primary_picture)
              , order_number = COALESCE(i_order_number, order_number)
            WHERE
                sale_group_picture_id = v_old.sale_group_picture_id;

            v_id := v_old.sale_group_picture_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;