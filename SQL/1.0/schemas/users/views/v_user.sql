DROP VIEW IF EXISTS users.v_user;
CREATE OR REPLACE VIEW users.v_user AS
SELECT
     u.user_id AS user_id
    ,u.insert_ts AS insert_ts
    ,u.update_ts AS update_ts
    ,u.first_name AS first_name
    ,u.last_name AS last_name
    ,u.email AS email
    ,ut.user_type_id AS user_type_id
    ,ut.user_type_name AS user_type_name
    ,u.active AS active
FROM users.user u
    INNER JOIN users.user_type ut ON u.user_type_id = ut.user_type_id
WHERE
    u.user_type_id = ut.user_type_id;
ALTER VIEW users.v_user_type OWNER TO store_db_su;
