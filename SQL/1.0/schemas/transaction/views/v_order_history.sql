DROP VIEW IF EXISTS transaction.v_order_history;
CREATE OR REPLACE VIEW transaction.v_order_history AS
SELECT
     oh.order_history_id AS order_history_id
    ,oh.order_id AS order_id
    ,oh.insert_ts AS insert_ts
    ,oh.description AS description
    ,oh.user_id AS user_id
    ,u.first_name AS first_name
    ,u.last_name AS last_name
    ,oh.order_history_type_id AS order_history_type_id
    ,oht.name AS order_history_type_name
FROM transaction.order_history oh
    INNER JOIN transaction.order_history_type oht ON oh.order_history_type_id = oht.order_history_type_id
    INNER JOIN users.user u ON oh.user_id = u.user_id;
ALTER VIEW transaction.v_order_history OWNER TO store_db_su;
