DROP VIEW IF EXISTS users.v_user_type;
CREATE OR REPLACE VIEW users.v_user_type AS
SELECT
     ut.user_type_id AS user_type_id
    ,ut.user_type_name AS user_type_name
FROM users.user_type ut;
ALTER VIEW users.v_user_type OWNER TO store_db_su;
