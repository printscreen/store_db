DROP FUNCTION IF EXISTS set_order_postage(
        i_order_postage_id          BIGINT
      , i_order_id                  BIGINT
      , i_carrier_id                BIGINT
      , i_tracking_number           TEXT
      , i_stamps_id                 TEXT
      , i_postage_service_type_id   BIGINT
      , i_postage_package_type_id   BIGINT
      , i_ship_date                 TIMESTAMPTZ
      , i_weight                    BIGINT
      , i_amount                    BIGINT
);

CREATE OR REPLACE FUNCTION set_order_postage(
        i_order_postage_id          BIGINT
      , i_order_id                  BIGINT
      , i_carrier_id                BIGINT
      , i_tracking_number           TEXT
      , i_stamps_id                 TEXT
      , i_postage_service_type_id   BIGINT
      , i_postage_package_type_id   BIGINT
      , i_ship_date                 TIMESTAMPTZ
      , i_weight                    BIGINT
      , i_amount                    BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_postage;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_postage WHERE order_postage_id = i_order_postage_id;

        IF v_old.order_postage_id IS NULL THEN
            INSERT INTO transaction.order_postage (
                  order_id
                , insert_ts
                , carrier_id
                , tracking_number
                , stamps_id
                , postage_service_type_id
                , postage_package_type_id
                , ship_date
                , weight
                , amount
            ) VALUES (
                  i_order_id
                , NOW()
                , i_carrier_id
                , i_tracking_number
                , i_stamps_id
                , i_postage_service_type_id
                , i_postage_package_type_id
                , i_ship_date
                , i_weight
                , i_amount
            );

            v_id := CURRVAL('transaction.order_postage_order_postage_id_seq');
        ELSE
            UPDATE transaction.order_postage SET
                  order_id = COALESCE(i_order_id, order_id)
                , carrier_id = COALESCE(i_carrier_id, carrier_id)
                , tracking_number = COALESCE(i_tracking_number, tracking_number)
                , stamps_id = COALESCE(i_stamps_id, stamps_id)
                , postage_service_type_id = COALESCE(i_postage_service_type_id, postage_service_type_id)
                , postage_package_type_id = COALESCE(i_postage_package_type_id, postage_package_type_id)
                , ship_date = COALESCE(i_ship_date, ship_date)
                , weight = COALESCE(i_weight, weight)
                , amount = COALESCE(i_amount, amount)
            WHERE
                order_postage_id = v_old.order_postage_id;

            v_id := v_old.order_postage_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
