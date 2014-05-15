DROP FUNCTION IF EXISTS set_carrier(
      i_carrier_id      BIGINT
    , i_carrier_name    CHARACTER VARYING
);

CREATE OR REPLACE FUNCTION set_carrier(
      i_carrier_id      BIGINT
    , i_carrier_name    CHARACTER VARYING
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.carrier;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.carrier WHERE carrier_id = i_carrier_id;
        IF v_old.carrier_id IS NULL THEN
            SELECT * INTO v_old FROM transaction.carrier WHERE lower(name) = lower(trim(i_carrier_name));
        END IF;

        IF v_old.carrier_id IS NULL THEN
            INSERT INTO transaction.carrier (
                name
            ) VALUES (
                i_carrier_name 
            );

            v_id := CURRVAL('transaction.carrier_carrier_id_seq');
        ELSE
            UPDATE transaction.carrier SET
                name = COALESCE(i_carrier_name, name)
            WHERE
                carrier_id = v_old.carrier_id;

            v_id := v_old.carrier_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
