DROP FUNCTION IF EXISTS set_postage_service_type(
        i_postage_service_type_id   BIGINT
      , i_postage_service_type_name VARCHAR
      , i_code                      VARCHAR
      , i_carrier_id                BIGINT
);
CREATE OR REPLACE FUNCTION set_postage_service_type(
        i_postage_service_type_id   BIGINT
      , i_postage_service_type_name VARCHAR
      , i_code                      VARCHAR
      , i_carrier_id                BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.postage_service_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.postage_service_type WHERE postage_service_type_id = i_postage_service_type_id;

        IF v_old.postage_service_type_id IS NULL THEN
            INSERT INTO transaction.postage_service_type (
                  name
                , carrier_id
                , code
            ) VALUES (
                  i_postage_service_type_name
                , i_carrier_id
                , i_code
            );

            v_id := CURRVAL('transaction.postage_service_type_postage_service_type_id_seq');
        ELSE
            UPDATE transaction.postage_service_type SET
                  name = COALESCE(i_postage_service_type_name, name)
                , carrier_id = COALESCE(i_carrier_id, carrier_id)
                , code = COALESCE(i_code, code)
            WHERE
                postage_service_type_id = v_old.postage_service_type_id;

            v_id := v_old.postage_service_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
