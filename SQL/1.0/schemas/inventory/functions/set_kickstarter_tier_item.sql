DROP FUNCTION IF EXISTS set_kickstarter_tier_item (
    i_kickstarter_item_id    BIGINT
  , i_kickstarter_tier_id    BIGINT
);
CREATE OR REPLACE FUNCTION set_kickstarter_tier_item (
    i_kickstarter_item_id    BIGINT
  , i_kickstarter_tier_id    BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.kickstarter_tier_item;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.kickstarter_tier_item WHERE kickstarter_item_id = i_kickstarter_item_id AND kickstarter_tier_id = i_kickstarter_tier_id;

        IF v_old.kickstarter_tier_item_id IS NOT NULL THEN
            v_id := v_old.kickstarter_tier_item_id;
        ELSE
            INSERT INTO inventory.kickstarter_tier_item (
                kickstarter_item_id
              , kickstarter_tier_id
            ) VALUES (
                i_kickstarter_item_id
              , i_kickstarter_tier_id
            );
            v_id := CURRVAL('inventory.kickstarter_tier_item_kickstarter_tier_item_id_seq');
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;