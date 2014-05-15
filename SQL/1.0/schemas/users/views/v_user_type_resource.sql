DROP VIEW IF EXISTS users.v_user_type_resource;
CREATE OR REPLACE VIEW users.v_user_type_resource AS
SELECT
     utr.user_type_resource_id AS user_type_resource_id
    ,utr.user_type_id AS user_type_id
    ,ut.user_type_name AS user_type_name
    ,utr.resource_id AS resource_id
    ,r.name AS resource_name
FROM users.user_type_resource utr
    INNER JOIN users.user_type ut ON ut.user_type_id = utr.user_type_id
    INNER JOIN application.resource r ON r.resource_id = utr.resource_id
WHERE
    ut.user_type_id = utr.user_type_id
AND
    r.resource_id = utr.resource_id;
ALTER VIEW users.v_user_type_resource OWNER TO store_db_su;
