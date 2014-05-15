DROP FUNCTION IF EXISTS set_item_attribute (
    i_attribute_id      BIGINT
  , i_item_id           BIGINT

);
CREATE OR REPLACE FUNCTION set_item_attribute (
    i_attribute_id      BIGINT
  , i_item_id           BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_find inventory.item_attribute;
        v_attribute inventory.attribute;
    BEGIN
        SELECT * INTO v_find FROM inventory.item_attribute WHERE attribute_id = i_attribute_id AND item_id = i_item_id;
        IF v_find.item_attribute_id IS NOT NULL THEN
            RETURN v_find.item_attribute_id;
        ELSE
            SELECT * INTO v_attribute FROM inventory.attribute WHERE attribute_id = i_attribute_id;
            IF v_attribute.parent_id IS NOT NULL THEN
                PERFORM set_item_attribute(v_attribute.parent_id,i_item_id);
            END IF;
                
            INSERT INTO inventory.item_attribute (
                attribute_id
              , item_id
            ) VALUES (
                i_attribute_id
              , i_item_id
            );
        
            RETURN CURRVAL('inventory.item_attribute_item_attribute_id_seq');
        END IF;
    END;
$_$
LANGUAGE PLPGSQL;