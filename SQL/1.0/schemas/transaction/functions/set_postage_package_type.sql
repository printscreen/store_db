DROP FUNCTION IF EXISTS set_postage_package_type(
        i_postage_package_type_id   BIGINT
      , i_postage_package_type_name VARCHAR
);
CREATE OR REPLACE FUNCTION set_postage_package_type(
        i_postage_package_type_id   BIGINT
      , i_postage_package_type_name VARCHAR
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.postage_package_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.postage_package_type WHERE postage_package_type_id = i_postage_package_type_id;

        IF v_old.postage_package_type_id IS NULL THEN
            INSERT INTO transaction.postage_package_type (
                  name
            ) VALUES (
                  i_postage_package_type_name
            );

            v_id := CURRVAL('transaction.postage_package_type_postage_package_type_id_seq');
        ELSE
            UPDATE transaction.postage_package_type SET
                  name = COALESCE(i_postage_package_type_name, name)
            WHERE
                postage_package_type_id = v_old.postage_package_type_id;

            v_id := v_old.postage_package_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
