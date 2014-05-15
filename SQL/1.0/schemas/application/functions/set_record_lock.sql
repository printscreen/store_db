DROP FUNCTION IF EXISTS set_record_lock (
    i_record_lock_id    BIGINT
  , i_table_name        VARCHAR(255)
  , i_record_id         BIGINT
  , i_session_id        VARCHAR(255)
  , i_user_id           BIGINT
);
CREATE OR REPLACE FUNCTION set_record_lock (
    i_record_lock_id    BIGINT
  , i_table_name        VARCHAR(255)
  , i_record_id         BIGINT
  , i_session_id        VARCHAR(255)
  , i_user_id           BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.record_lock;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.record_lock WHERE record_lock_id = i_record_lock_id;
        IF v_old.record_lock_id IS NULL THEN
            SELECT * INTO v_old FROM application.record_lock WHERE table_name = lower(i_table_name) AND record_id = i_record_id;
        END IF;

        IF v_old.record_lock_id IS NULL THEN
            INSERT INTO application.record_lock (
                table_name
              , record_id
              , session_id
              , user_id
              , insert_ts
            ) VALUES (
                lower(i_table_name)
              , i_record_id
              , i_session_id
              , i_user_id
              , NOW()
            );

            v_id := CURRVAL('application.record_lock_record_lock_id_seq');
        ELSE
            UPDATE application.record_lock SET
                table_name = COALESCE(lower(i_table_name), table_name)
              , record_id = COALESCE(i_record_id, record_id)
              , session_id = COALESCE(i_session_id, session_id)
              , user_id = COALESCE(i_user_id, user_id)
            WHERE
                record_lock_id = v_old.record_lock_id;

            v_id := v_old.record_lock_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
