DROP VIEW IF EXISTS application.v_resource;
CREATE OR REPLACE VIEW application.v_resource AS
SELECT
     r.resource_id AS resource_id
    ,r.name        AS resource_name
FROM application.resource r;
ALTER VIEW application.v_resource OWNER TO store_db_su;
