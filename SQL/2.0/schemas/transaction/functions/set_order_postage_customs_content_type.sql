DROP FUNCTION IF EXISTS set_order_postage_customs_content_type (
    i_order_postage_customs_content_type_id BIGINT
  , i_name                                  VARCHAR(255)
);
CREATE OR REPLACE FUNCTION set_order_postage_customs_content_type (
    i_order_postage_customs_content_type_id BIGINT
  , i_name                                  VARCHAR(255)
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_postage_customs_content_type;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_postage_customs_content_type WHERE order_postage_customs_content_type_id = i_order_postage_customs_content_type_id;        

        IF v_old.order_postage_customs_content_type_id IS NULL THEN
            INSERT INTO transaction.order_postage_customs_content_type (
                name
            ) VALUES (
                i_name
            );

            v_id := CURRVAL('transaction.order_postage_customs_content_type_order_postage_customs_content_type_id_seq');
        ELSE
            UPDATE transaction.order_postage_customs_content_type SET
                name = COALESCE(i_name, name)
            WHERE
                order_postage_customs_content_type_id = v_old.order_postage_customs_content_type_id;

            v_id := v_old.order_postage_customs_content_type_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;