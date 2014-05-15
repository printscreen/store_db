DROP FUNCTION IF EXISTS set_item_file_path_orgin (
    i_item_file_path_orgin_id      BIGINT
  , i_item_file_path_orgin_name    VARCHAR(128)
);
CREATE OR REPLACE FUNCTION set_item_file_path_orgin (
    i_item_file_path_orgin_id      BIGINT
  , i_item_file_path_orgin_name    VARCHAR(128)
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.item_file_path_orgin;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.item_file_path_orgin WHERE item_file_path_orgin_id = i_item_file_path_orgin_id;
        IF v_old.item_file_path_orgin_id IS NULL THEN
            SELECT * INTO v_old FROM inventory.item_file_path_orgin WHERE name = lower(trim(i_item_file_path_orgin_name));
        END IF;
        
        IF v_old.item_file_path_orgin_id IS NULL THEN
            INSERT INTO inventory.item_file_path_orgin (
                name
            ) VALUES (
                i_item_file_path_orgin_name
            );

            v_id := CURRVAL('inventory.item_file_path_orgin_item_file_path_orgin_id_seq');
        ELSE
            UPDATE inventory.item_file_path_orgin SET
                name = COALESCE(i_item_file_path_orgin_name, name)
            WHERE
                item_file_path_orgin_id = v_old.item_file_path_orgin_id;

            v_id := v_old.item_file_path_orgin_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
