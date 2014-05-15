DROP FUNCTION IF EXISTS set_item (
    i_item_id       BIGINT
  , i_code          VARCHAR(128)
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_item_type_id  BIGINT
  , i_price         BIGINT
  , i_quantity      BIGINT
  , i_weight_ounces BIGINT
  , i_active        BOOLEAN
);
DROP FUNCTION IF EXISTS set_item (
    i_item_id       BIGINT
  , i_code          VARCHAR(128)
  , i_name          VARCHAR(128)
  , i_item_type_id  BIGINT
  , i_description   TEXT
  , i_quantity      BIGINT
  , i_weight_ounces BIGINT
  , i_active        BOOLEAN
);
CREATE OR REPLACE FUNCTION set_item (
    i_item_id       BIGINT
  , i_code          VARCHAR(128)
  , i_name          VARCHAR(128)
  , i_item_type_id  BIGINT
  , i_description   TEXT
  , i_quantity      BIGINT
  , i_weight_ounces BIGINT
  , i_active        BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.item;
        v_id BIGINT;
        v_quantity BIGINT;
        v_weight BIGINT;
        v_item_type_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.item WHERE item_id = i_item_id;
        
        IF v_old.item_id IS NULL THEN
        
            IF i_item_type_id = 2 THEN
                v_quantity = 999999999;
                v_weight = 0;
            ELSE
                v_quantity = 0;
                v_weight = i_weight_ounces;
            END IF;
        
            INSERT INTO inventory.item (
                code
              , name
              , item_type_id
              , description
              , quantity
              , active
              , weight_ounces
            ) VALUES (
                i_code
              , i_name
              , i_item_type_id
              , i_description
              , v_quantity
              , i_active
              , v_weight
            );

            v_id := CURRVAL('inventory.item_item_id_seq');

        ELSE
            v_item_type_id = COALESCE(i_item_type_id, v_old.item_type_id);
            IF v_item_type_id = 2 THEN
                v_quantity = 1;
                v_weight = 0;
            ELSE
                v_quantity = COALESCE(i_quantity, v_old.quantity);
                v_weight = COALESCE(i_weight_ounces, v_old.weight_ounces);
            END IF;
        
            UPDATE inventory.item SET
                code = COALESCE(i_code, code)
              , name = COALESCE(i_name, name)
              , item_type_id = v_item_type_id
              , description = COALESCE(i_description, description)
              , quantity = v_quantity
              , weight_ounces = v_weight
              , active = COALESCE(i_active, active)
            WHERE
                item_id = v_old.item_id;

            v_id := v_old.item_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
