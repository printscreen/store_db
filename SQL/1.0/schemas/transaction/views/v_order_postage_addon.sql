DROP VIEW IF EXISTS transaction.v_order_postage_addon;
CREATE OR REPLACE VIEW transaction.v_order_postage_addon AS
SELECT
     opa.order_postage_addon_id AS order_postage_addon_id
    ,opa.order_postage_id AS order_postage_id
    ,op.order_id AS order_id
    ,opa.carrier_addon_id AS carrier_addon_id
    ,ca.name AS carrier_addon_name
    ,ca.carrier_id AS carrier_id
    ,c.name AS carrier_name
FROM transaction.order_postage_addon opa
    INNER JOIN transaction.order_postage op ON opa.order_postage_id = op.order_postage_id
    INNER JOIN transaction.carrier_addon ca ON opa.carrier_addon_id = ca.carrier_addon_id
    INNER JOIN transaction.carrier c ON ca.carrier_id = c.carrier_id;
ALTER VIEW transaction.v_order_postage_addon OWNER TO store_db_su;
