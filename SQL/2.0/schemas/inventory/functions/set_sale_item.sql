DROP FUNCTION IF EXISTS set_sale_item (
    i_sale_item_id  BIGINT
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_price         BIGINT
  , i_active        BOOLEAN
);
CREATE OR REPLACE FUNCTION set_sale_item (
    i_sale_item_id  BIGINT
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_price         BIGINT
  , i_active        BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_item;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_item WHERE sale_item_id = i_sale_item_id;
        
        IF v_old.sale_item_id IS NULL THEN

            INSERT INTO inventory.sale_item (
                name
              , description
              , price
              , active
              , insert_ts
            ) VALUES (
                i_name
              , i_description
              , i_price
              , i_active
              , NOW()
            );

            v_id := CURRVAL('inventory.sale_item_sale_item_id_seq');

        ELSE
            UPDATE inventory.sale_item SET
                name = COALESCE(i_name, name)
              , description = COALESCE(i_description, description)
              , price = COALESCE(i_price, price)
              , active = COALESCE(i_active, active)
            WHERE
                sale_item_id = v_old.sale_item_id;

            v_id := v_old.sale_item_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;