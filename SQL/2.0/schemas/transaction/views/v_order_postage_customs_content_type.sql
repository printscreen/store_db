DROP VIEW IF EXISTS transaction.v_order_postage_customs_content_type;
CREATE OR REPLACE VIEW transaction.v_order_postage_customs_content_type AS
SELECT
     ct.order_postage_customs_content_type_id AS order_postage_customs_content_type_id
    ,ct.name AS name
FROM transaction.order_postage_customs_content_type ct;
ALTER VIEW transaction.v_order_postage_customs_content_type OWNER TO store_db_su;
