DROP VIEW IF EXISTS application.v_user_type_resource_group CASCADE;
CREATE OR REPLACE VIEW application.v_user_type_resource_group AS
SELECT DISTINCT
     rg.resource_group_id AS resource_group_id
   , rg.name AS name
   , rg.description AS description
   , utr.user_type_id AS user_type_id
FROM application.resource_group rg
INNER JOIN application.resource_group_resource rgr ON rgr.resource_group_id = rg.resource_group_id
INNER JOIN users.user_type_resource utr ON rgr.resource_id = utr.resource_id;
ALTER VIEW application.v_user_type_resource_group OWNER TO store_db_su;
