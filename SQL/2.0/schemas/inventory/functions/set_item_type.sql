DROP FUNCTION IF EXISTS set_item_type (
    i_item_type_id      BIGINT
  , i_item_type_name    VARCHAR(128)
);
CREATE OR REPLACE FUNCTION set_item_type (
    i_item_type_id      BIGINT
  , i_item_type_name    VARCHAR(128)
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.item_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.item_type WHERE item_type_id = i_item_type_id;
        IF v_old.item_type_id IS NULL THEN
            SELECT * INTO v_old FROM inventory.item_type WHERE name = lower(trim(i_item_type_name));
        END IF;
        

        IF v_old.item_type_id IS NULL THEN
            INSERT INTO inventory.item_type (
                name
            ) VALUES (
                i_item_type_name
            );

            v_id := CURRVAL('inventory.item_type_item_type_id_seq');
        ELSE
            UPDATE inventory.item_type SET
                name = COALESCE(i_item_type_name, name)
            WHERE
                item_type_id = v_old.item_type_id;

            v_id := v_old.item_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
