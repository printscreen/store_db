DROP FUNCTION IF EXISTS set_kickstarter_tier (
    i_kickstater_tier_id    BIGINT
  , i_amount                INTEGER
  , i_name                  VARCHAR(255)
  , i_description           TEXT
);
CREATE OR REPLACE FUNCTION set_kickstarter_tier (
    i_kickstater_tier_id    BIGINT
  , i_amount                INTEGER
  , i_name                  VARCHAR(255)
  , i_description           TEXT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.kickstarter_tier;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.kickstarter_tier WHERE kickstarter_tier_id = i_kickstarter_tier_id;
        
        IF v_old.kickstarter_tier_id IS NULL THEN
        
            INSERT INTO inventory.kickstarter_tier (
                amount
              , name
              , description
            ) VALUES (
                i_amount
              , i_name
              , i_description
            );

            v_id := CURRVAL('inventory.kickstarter_tier_kickstarter_tier_id_seq');

        ELSE
            UPDATE inventory.kickstarter_tier SET
                amount = COALESCE(i_amount, amount)
              , name = COALESCE(i_name, name)
              , description = COALESCE(i_description, description)
            WHERE
                kickstarter_tier_id = v_old.kickstarter_tier_id;

            v_id := v_old.kickstarter_tier_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
