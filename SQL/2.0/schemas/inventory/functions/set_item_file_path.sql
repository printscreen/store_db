DROP FUNCTION IF EXISTS set_item_file_path (
    i_item_file_path_id         BIGINT
  , i_file_path                 VARCHAR(255)
  , i_item_file_path_orgin_id   BIGINT
  , i_item_id                   BIGINT
);
CREATE OR REPLACE FUNCTION set_item_file_path (
    i_item_file_path_id         BIGINT
  , i_file_path                 VARCHAR(255)
  , i_item_file_path_orgin_id   BIGINT
  , i_item_id                   BIGINT
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.item_file_path;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.item_file_path WHERE item_file_path_id = i_item_file_path_id;
        IF v_old.item_file_path_id IS NULL THEN
            SELECT * INTO v_old FROM inventory.item_file_path WHERE item_id = i_item_id;
        END IF;
        

        IF v_old.item_file_path_id IS NULL THEN
            INSERT INTO inventory.item_file_path (
                file_path
              , item_file_path_orgin_id
              , item_id
            ) VALUES (
                i_file_path
              , i_item_file_path_orgin_id
              , i_item_id
            );

            v_id := CURRVAL('inventory.item_file_path_item_file_path_id_seq');
        ELSE
            UPDATE inventory.item_file_path SET
                item_file_path_orgin_id = COALESCE(i_item_file_path_orgin_id, item_file_path_orgin_id)
              , file_path = COALESCE(i_file_path, file_path)
              , item_id = COALESCE(i_item_id, item_id)
            WHERE
                item_file_path_id = v_old.item_file_path_id;

            v_id := v_old.item_file_path_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
