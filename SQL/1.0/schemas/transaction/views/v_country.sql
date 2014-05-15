DROP VIEW IF EXISTS transaction.v_country;
CREATE OR REPLACE VIEW transaction.v_country AS
SELECT
     c.country_id AS country_id
    ,c.name AS country_name
    ,c.code AS country_code
    ,c.active AS active
FROM transaction.country c;
ALTER VIEW transaction.v_country OWNER TO store_db_su;
