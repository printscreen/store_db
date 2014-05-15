DROP VIEW IF EXISTS inventory.v_key;
CREATE OR REPLACE VIEW inventory.v_key AS
SELECT
     k.key_id AS key_id
    ,k.key AS key
    ,k.item_id AS item_id
    ,i.name AS item_name
    ,k.user_id AS user_id
    ,u.first_name || ' ' || u.last_name AS user_name
    ,k.insert_ts AS insert_ts
FROM inventory.key k
INNER JOIN inventory.item i ON i.item_id = k.item_id
INNER JOIN users.user u ON u.user_id = k.user_id;
ALTER VIEW inventory.v_key OWNER TO store_db_su;