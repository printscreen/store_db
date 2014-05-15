DROP FUNCTION IF EXISTS set_carrier_addon(
        i_carrier_addon_id      BIGINT
      , i_carrier_addon_name    VARCHAR
      , i_carrier_id            BIGINT
      , i_code                  VARCHAR
);
CREATE OR REPLACE FUNCTION set_carrier_addon(
        i_carrier_addon_id      BIGINT
      , i_carrier_addon_name    VARCHAR
      , i_carrier_id            BIGINT
      , i_code                  VARCHAR
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.carrier_addon;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.carrier_addon WHERE carrier_addon_id = i_carrier_addon_id;

        IF v_old.carrier_addon_id IS NULL THEN
            INSERT INTO transaction.carrier_addon (
                  name
                , code
                , carrier_id
            ) VALUES (
                  i_carrier_addon_name
                , i_code
                , i_carrier_id
            );

            v_id := CURRVAL('transaction.carrier_addon_carrier_addon_id_seq');
        ELSE
            UPDATE transaction.carrier_addon SET
                  name = COALESCE(i_carrier_addon_name, name)
                , code = COALESCE(i_code, code)
                , carrier_id = COALESCE(i_carrier_id, carrier_id)
            WHERE
                carrier_addon_id = v_old.carrier_addon_id;
            v_id := v_old.carrier_addon_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
