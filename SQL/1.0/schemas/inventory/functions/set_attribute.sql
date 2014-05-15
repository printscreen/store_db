DROP FUNCTION IF EXISTS set_attribute (
    i_attribute_id      BIGINT
  , i_attribute_name    VARCHAR(128)
  , i_parent_id         BIGINT

);
CREATE OR REPLACE FUNCTION set_attribute (
    i_attribute_id      BIGINT
  , i_attribute_name    VARCHAR(128)
  , i_parent_id         BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.attribute;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.attribute WHERE attribute_id = i_attribute_id;
        IF v_old.attribute_id IS NULL THEN
            SELECT * INTO v_old FROM inventory.attribute WHERE name = lower(trim(i_attribute_name)) AND parent_id = i_parent_id;
        END IF;
        
        IF v_old.attribute_id IS NULL THEN

            INSERT INTO inventory.attribute (
                name
              , parent_id
            ) VALUES (
                i_attribute_name
              , i_parent_id
            );

            v_id := CURRVAL('inventory.attribute_attribute_id_seq');

        ELSE
            UPDATE inventory.item SET
                name = COALESCE(i_attribute_name, name)
              , parent_id = COALESCE(i_parent_id, parent_id)
            WHERE
                attribute_id = v_old.attribute_id;

            v_id := v_old.attribute_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
