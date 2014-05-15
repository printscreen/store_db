DROP FUNCTION IF EXISTS set_country(
      i_country_id      BIGINT
    , i_country_name    CHARACTER VARYING
    , i_country_code    CHARACTER VARYING
    , i_active          BOOLEAN
);

CREATE OR REPLACE FUNCTION set_country(
      i_country_id      BIGINT
    , i_country_name    CHARACTER VARYING
    , i_country_code    CHARACTER VARYING
    , i_active          BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.country;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.country WHERE country_id = i_country_id;

        IF v_old.country_id IS NULL THEN
            INSERT INTO transaction.country (
                name
              , code
              , active
            ) VALUES (
                i_country_name
              , i_country_code
              , i_active
            );

            v_id := CURRVAL('transaction.country_country_id_seq');
        ELSE
            UPDATE transaction.country SET
                name = COALESCE(i_country_name, name)
              , code = COALESCE(i_country_code, code)
              , active = COALESCE(i_active, active)
            WHERE
                country_id = v_old.country_id;

            v_id := v_old.country_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
