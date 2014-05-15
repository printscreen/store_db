DROP VIEW IF EXISTS transaction.v_carrier_addon;
CREATE OR REPLACE VIEW transaction.v_carrier_addon AS
SELECT
     ca.carrier_addon_id AS carrier_addon_id
    ,ca.name AS carrier_addon_name
    ,ca.code AS code
    ,ca.carrier_id AS carrier_id
    ,c.name AS carrier_name
FROM transaction.carrier_addon ca
    INNER JOIN transaction.carrier c ON ca.carrier_id = c.carrier_id;
ALTER VIEW transaction.v_carrier_addon OWNER TO store_db_su;
