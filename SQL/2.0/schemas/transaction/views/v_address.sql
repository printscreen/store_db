DROP VIEW IF EXISTS transaction.v_address CASCADE;
CREATE OR REPLACE VIEW transaction.v_address AS
SELECT
     a.address_id AS address_id
    ,a.insert_ts AS insert_ts
    ,a.update_ts AS update_ts
    ,a.street AS street
    ,a.unit_number AS unit_number
    ,a.city AS city
    ,a.state AS state
    ,a.postal_code AS postal_code
    ,a.country_id AS country_id
    ,c.name AS country_name
    ,c.code AS country_code
    ,a.phone_number AS phone_number
    ,a.user_id AS user_id
    ,a.first_name AS first_name
    ,a.last_name AS last_name
    ,a.active AS active
    ,a.hash AS hash
FROM transaction.address a
    INNER JOIN transaction.country c ON a.country_id = c.country_id
WHERE
    a.country_id = c.country_id;
ALTER VIEW transaction.v_address OWNER TO store_db_su;
