DROP FUNCTION IF EXISTS set_sale_group (
    i_sale_group_id BIGINT
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_url           VARCHAR(255)
  , i_active        BOOLEAN
);
CREATE OR REPLACE FUNCTION set_sale_group (
    i_sale_group_id BIGINT
  , i_name          VARCHAR(128)
  , i_description   TEXT
  , i_url           VARCHAR(255)
  , i_active        BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.sale_group;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.sale_group WHERE sale_group_id = i_sale_group_id;
        
        IF v_old.sale_group_id IS NULL THEN

            INSERT INTO inventory.sale_group (
                name
              , description
              , url
              , active
              , insert_ts
            ) VALUES (
                i_name
              , i_description
              , i_url
              , i_active
              , NOW()
            );

            v_id := CURRVAL('inventory.sale_group_sale_group_id_seq');

        ELSE
            UPDATE inventory.sale_group SET
                name = COALESCE(i_name, name)
              , description = COALESCE(i_description, description)
              , url = COALESCE(i_url, url)
              , active = COALESCE(i_active, active)
            WHERE
                sale_group_id = v_old.sale_group_id;

            v_id := v_old.sale_group_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;