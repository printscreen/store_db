DROP VIEW IF EXISTS transaction.v_order_shipping;
CREATE OR REPLACE VIEW transaction.v_order_shipping AS
SELECT
     os.order_shipping_id AS order_shipping_id
    ,os.insert_ts AS shipping_insert_ts
    ,os.update_ts AS shipping_update_ts
    ,os.first_name AS shipping_first_name
    ,os.last_name AS shipping_last_name
    ,os.order_id AS order_id
    ,os.shipping_cost AS shipping_cost
    ,os.address_id AS address_id
    ,a.insert_ts AS address_insert_ts
    ,a.update_ts AS address_update_ts
    ,a.street AS street
    ,a.unit_number AS unit_number
    ,a.city AS city
    ,a.state AS state
    ,a.postal_code AS postal_code
    ,a.country_id AS country_id
    ,c.name AS country_name
    ,c.code AS country_code
    ,a.user_id AS user_id
    ,u.first_name AS user_first_name
    ,u.last_name AS user_last_name
    ,a.active AS active
    ,a.hash AS hash
FROM transaction.order_shipping os
    LEFT JOIN transaction.address a ON os.address_id = a.address_id
    LEFT JOIN transaction.country c ON a.country_id = c.country_id
    LEFT JOIN users.user u ON a.user_id = u.user_id;
ALTER VIEW transaction.v_order_shipping OWNER TO store_db_su;
