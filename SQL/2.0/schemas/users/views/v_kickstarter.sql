DROP VIEW IF EXISTS users.v_kickstarter;
CREATE OR REPLACE VIEW users.v_kickstarter AS
SELECT
     k.kickstarter_id AS kickstarter_id
    ,k.tier_id AS tier_id
    ,k.name AS name
    ,k.first_name AS first_name
    ,k.last_name AS last_name
    ,k.email AS email
    ,k.prefered_email AS prefered_email
    ,k.user_id AS user_id
    ,k.order_id AS order_id
    ,k.address_id AS address_id
    ,k.password AS password
    ,k.street AS street
    ,k.unit_number AS unit_number
    ,k.city AS city
    ,k.state AS state
    ,k.postal_code AS postal_code
    ,k.country_id AS country_id
    ,c.name AS country_name
    ,c.code AS country_code
    ,k.phone_number AS phone_number
    ,k.shirt_size AS shirt_size
    ,k.shirt_sex AS shirt_sex
    ,k.notes AS notes
    ,k.hash AS hash
    ,k.last_sent_hash AS last_sent_hash
    ,k.update_ts AS update_ts
    ,k.verified AS verified
FROM users.kickstarter k
    LEFT JOIN transaction.country c ON k.country_id = c.country_id;
ALTER VIEW users.v_user_type OWNER TO store_db_su;