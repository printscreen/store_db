DROP VIEW IF EXISTS application.v_record_lock;
CREATE OR REPLACE VIEW application.v_record_lock AS
SELECT
     rl.record_lock_id AS record_lock_id
    ,rl.table_name AS table_name
    ,rl.record_id AS record_id
    ,rl.session_id AS session_id
    ,rl.user_id AS user_id
    ,u.first_name AS first_name
    ,u.last_name AS last_name
    ,u.email AS email
    ,rl.insert_ts AS insert_ts
FROM application.record_lock rl
INNER JOIN users.user u ON rl.user_id = u.user_id;
ALTER VIEW application.v_record_lock OWNER TO store_db_su;
