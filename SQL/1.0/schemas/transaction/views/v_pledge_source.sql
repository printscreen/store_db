DROP VIEW IF EXISTS transaction.v_pledge_source;
CREATE OR REPLACE VIEW transaction.v_pledge_source AS
SELECT
     ps.pledge_source_id AS pledge_source_id
    ,ps.name AS pledge_source_name
FROM transaction.pledge_source ps;
ALTER VIEW transaction.v_pledge_source OWNER TO store_db_su;
