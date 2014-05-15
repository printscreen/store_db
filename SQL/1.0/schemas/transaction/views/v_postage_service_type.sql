DROP VIEW IF EXISTS transaction.v_postage_service_type;
CREATE OR REPLACE VIEW transaction.v_postage_service_type AS
SELECT
     st.postage_service_type_id AS postage_service_type_id
    ,st.name AS postage_service_type_name
    ,st.code AS code
    ,st.carrier_id AS carrier_id
    ,c.name AS carrier_name
FROM transaction.postage_service_type st
    INNER JOIN transaction.carrier c ON st.carrier_id = c.carrier_id;
ALTER VIEW transaction.v_postage_service_type OWNER TO store_db_su;
