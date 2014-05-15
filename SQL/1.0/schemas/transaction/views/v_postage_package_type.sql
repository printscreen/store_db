DROP VIEW IF EXISTS transaction.v_postage_package_type;
CREATE OR REPLACE VIEW transaction.v_postage_package_type AS
SELECT
     pt.postage_package_type_id AS postage_package_type_id
    ,pt.name AS postage_package_type_name
FROM transaction.postage_package_type pt;
ALTER VIEW transaction.v_postage_package_type OWNER TO store_db_su;
