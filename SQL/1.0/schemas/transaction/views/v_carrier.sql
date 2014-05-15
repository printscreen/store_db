DROP VIEW IF EXISTS transaction.v_carrier;
CREATE OR REPLACE VIEW transaction.v_carrier AS
SELECT
     c.carrier_id AS carrier_id
    ,c.name AS carrier_name
FROM transaction.carrier c;
ALTER VIEW transaction.v_carrier OWNER TO store_db_su;
