DROP FUNCTION IF EXISTS set_order_history(
        i_order_history_id  BIGINT
      , i_order_id          BIGINT
      , i_user_id           BIGINT
      , i_description       TEXT
      , i_history_type_id   BIGINT
);
CREATE OR REPLACE FUNCTION set_order_history(
        i_order_history_id  BIGINT
      , i_order_id          BIGINT
      , i_user_id           BIGINT
      , i_description       TEXT
      , i_history_type_id   BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.order_history;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.order_history WHERE order_history_id = i_order_history_id;

        IF v_old.order_history_id IS NULL THEN
            INSERT INTO transaction.order_history (
                  insert_ts
                , order_id
                , user_id
                , description
                , order_history_type_id
            ) VALUES (
                  NOW()
                , i_order_id
                , i_user_id
                , i_description
                , i_history_type_id
            );

            v_id := CURRVAL('transaction.order_history_order_history_id_seq');
        ELSE
            UPDATE transaction.order_history SET
                  order_id = COALESCE(i_order_id, order_id)
                , user_id = COALESCE(i_user_id, user_id)
                , description = COALESCE(i_description, description)
                , order_history_type_id = COALESCE(i_history_type_id, order_history_type_id)
            WHERE
                order_history_id = v_old.order_history_id;

            v_id := v_old.order_history_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
