DROP VIEW IF EXISTS application.v_resource_group CASCADE;
CREATE OR REPLACE VIEW application.v_resource_group AS
SELECT
     rg.resource_group_id AS resource_group_id
   , rg.name AS name
   , rg.description AS description
FROM application.resource_group rg;
ALTER VIEW application.v_resource_group OWNER TO store_db_su;
