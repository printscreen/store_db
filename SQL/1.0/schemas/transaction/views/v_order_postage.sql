DROP VIEW IF EXISTS transaction.v_order_postage;
CREATE OR REPLACE VIEW transaction.v_order_postage AS
SELECT
     op.order_postage_id AS order_postage_id
    ,op.order_id AS order_id
    ,op.insert_ts AS insert_ts
    ,op.file_location AS file_location
    ,op.carrier_id AS carrier_id
    ,c.name AS carrier_name
    ,op.tracking_number AS tracking_number
    ,op.stamps_id AS stamps_id
    ,op.postage_service_type_id AS postage_service_type_id
    ,st.name AS postage_service_type_name
    ,st.code AS postage_service_type_code
    ,op.postage_package_type_id AS postage_package_type_id
    ,pt.name AS postage_package_type_name
    ,op.ship_date AS ship_date
    ,op.weight AS weight
    ,op.amount AS amount
FROM transaction.order_postage op
    INNER JOIN transaction.carrier c ON op.carrier_id = c.carrier_id
    INNER JOIN transaction.postage_service_type st ON op.postage_service_type_id = st.postage_service_type_id
    INNER JOIN transaction.postage_package_type pt ON op.postage_package_type_id = pt.postage_package_type_id;
ALTER VIEW transaction.v_order_postage OWNER TO store_db_su;
