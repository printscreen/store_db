DROP VIEW IF EXISTS transaction.v_order_billing;
CREATE OR REPLACE VIEW transaction.v_order_billing AS
SELECT
     ob.order_billing_id AS order_billing_id
    ,ob.insert_ts AS billing_insert_ts
    ,ob.update_ts AS billing_update_ts
    ,ob.first_name AS billing_first_name
    ,ob.last_name AS billing_last_name
    ,ob.authorization_number AS authorization_number
    ,ob.order_id AS order_id
    ,ob.address_id AS address_id
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
FROM transaction.order_billing ob
    LEFT JOIN transaction.address a ON ob.address_id = a.address_id
    LEFT JOIN transaction.country c ON a.country_id = c.country_id
    LEFT JOIN users.user u ON a.user_id = u.user_id;
ALTER VIEW transaction.v_order_billing OWNER TO store_db_su;
