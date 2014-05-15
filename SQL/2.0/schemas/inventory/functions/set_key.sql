DROP FUNCTION IF EXISTS set_key (
    i_key_id        BIGINT
  , i_key           TEXT
  , i_item_id       BIGINT
  , i_user_id       BIGINT
);
CREATE OR REPLACE FUNCTION set_key (
    i_key_id        BIGINT
  , i_key           TEXT
  , i_item_id       BIGINT
  , i_user_id       BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.key;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM inventory.key WHERE key_id = i_key_id;
        
        IF v_old.key_id IS NULL THEN
        
            INSERT INTO inventory.key (
                key
              , item_id
              , user_id
              , insert_ts
            ) VALUES (
                i_key
              , i_item_id
              , i_user_id
              , NOW()
            );

            v_id := CURRVAL('inventory.key_key_id_seq');

        ELSE
            UPDATE inventory.key SET
                key = COALESCE(i_name, key)
              , item_id = COALESCE(i_item_id, item_id)
              , user_id = COALESCE(i_user_id, user_id)
            WHERE
                key_id = v_old.key_id;

            v_id := v_old.key_id;
        END IF;
        UPDATE inventory.item SET quantity = (SELECT count(*) FROM inventory.key WHERE item_id = i_item_id) WHERE item_id = i_item_id;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS set_key (
    i_keys          TEXT[]
  , i_item_id       BIGINT
  , i_user_id       BIGINT
);
CREATE OR REPLACE FUNCTION set_key (
    i_keys          TEXT[]
  , i_item_id       BIGINT
  , i_user_id       BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_key TEXT;
    BEGIN
        FOR v_key IN SELECT * FROM unnest(i_keys) LOOP
            INSERT INTO inventory.key (
                key
              , item_id
              , user_id
              , insert_ts
            ) VALUES (
                v_key
              , i_item_id
              , i_user_id
              , NOW()
            );
        END LOOP;
        UPDATE inventory.item SET quantity = (SELECT count(*) FROM inventory.key WHERE item_id = i_item_id) WHERE item_id = i_item_id;
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;