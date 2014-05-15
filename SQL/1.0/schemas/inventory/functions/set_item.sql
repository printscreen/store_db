DROP FUNCTION IF EXISTS set_item (
    i_item_id       BIGINT
  , i_code          VARCHAR(128)
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_price         BIGINT
  , i_quantity      BIGINT
  , i_weight_ounces BIGINT
  , i_active        BOOLEAN
);
CREATE OR REPLACE FUNCTION set_item (
    i_item_id       BIGINT
  , i_code          VARCHAR(128)
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_price         BIGINT
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
    BEGIN
        SELECT * INTO v_old FROM inventory.item WHERE item_id = i_item_id;
        
        IF v_old.item_id IS NULL THEN
            IF i_code IS NULL OR i_name IS NULL OR i_name IS NULL OR i_description IS NULL OR i_active IS NULL
            OR i_price IS NULL OR i_quantity IS NULL THEN
                return -1;
            END IF;
        
            INSERT INTO inventory.item (
                code
              , name
              , description
              , active
              , weight_ounces
            ) VALUES (
                i_code
              , i_name
              , i_description
              , i_active
              , i_weight_ounces
            );

            v_id := CURRVAL('inventory.item_item_id_seq');
 
            INSERT INTO inventory.item_price (
                item_id
              , update_ts
              , price
            ) VALUES (
                v_id
              , NOW()
              , i_price
            );
            
            INSERT INTO inventory.item_quantity(
                item_id
              , quantity
            ) VALUES (
                v_id
              , i_quantity
            );

        ELSE
            UPDATE inventory.item SET
                code = COALESCE(i_code, code)
              , name = COALESCE(i_name, name)
              , description = COALESCE(i_description, description)
              , weight_ounces = COALESCE(i_weight_ounces, weight_ounces)
              , active = COALESCE(i_active, active)
            WHERE
                item_id = v_old.item_id;
                
            
            IF i_price IS NOT NULL THEN
                UPDATE inventory.item_price SET
                      update_ts = NOW()
                    , price = COALESCE(i_price, price)
                WHERE 
                   item_id = v_old.item_id
                   AND i_price != price; 
            END IF;
            
            UPDATE inventory.item_quantity SET
                quantity = COALESCE(i_quantity, quantity)
            WHERE
                item_id = v_old.item_id;
            v_id := v_old.item_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
