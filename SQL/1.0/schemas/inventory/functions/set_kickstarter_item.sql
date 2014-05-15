DROP FUNCTION IF EXISTS set_kickstarter_item (
    i_kickstater_item_id    BIGINT
  , i_name                  VARCHAR(255)
  , i_description           TEXT
  , i_is_physicial_item     BOOLEAN
  , i_kickstater_tier_id    BIGINT
);
CREATE OR REPLACE FUNCTION set_kickstarter_item (
    i_kickstater_item_id    BIGINT
  , i_name                  VARCHAR(255)
  , i_description           TEXT
  , i_is_physicial_item     BOOLEAN
  , i_kickstater_tier_id    BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.kickstarter_item;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.kickstarter_item WHERE kickstarter_item_id = i_kickstarter_item_id;
        
        IF v_old.kickstarter_item_id IS NULL THEN
        
            INSERT INTO inventory.kickstarter_item (
                name
              , description
              , is_physical_item
              , kickstarter_tier_id
            ) VALUES (
                i_name
              , i_description
              , i_is_physical_item
              , i_kickstarter_tier_id
            );

            v_id := CURRVAL('inventory.kickstarter_item_kickstarter_item_id_seq');

        ELSE
            UPDATE inventory.kickstarter_item SET
                name = COALESCE(i_name, name)
              , description = COALESCE(i_description, description)
              , is_physical_item = COALESCE(i_is_physical_item, is_physical_item)
              , kickstarter_tier_id = COALESCE(i_kickstarter_id, kickstarter_tier_id)
            WHERE
                kickstarter_item_id = v_old.kickstarter_item_id;

            v_id := v_old.kickstarter_item_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
