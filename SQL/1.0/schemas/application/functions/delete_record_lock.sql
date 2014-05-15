DROP FUNCTION IF EXISTS delete_record_lock (
    i_record_lock_id    BIGINT
  , i_table_name        VARCHAR(255)
  , i_record_id         BIGINT
);
CREATE OR REPLACE FUNCTION delete_record_lock (
    i_record_lock_id    BIGINT
  , i_table_name        VARCHAR(255)
  , i_record_id         BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_find application.record_lock;
    BEGIN

        
        SELECT * INTO v_find FROM application.record_lock WHERE record_lock_id = i_record_lock_id;
        IF v_find.record_lock_id IS NULL THEN
            SELECT * INTO v_find FROM application.record_lock WHERE table_name = lower(i_table_name) AND record_id = i_record_id;
        END IF;
        
        IF v_find.record_lock_id IS NULL THEN
            return false;
        END IF;
        
        DELETE FROM application.record_lock WHERE record_lock_id = v_find.record_lock_id;

        RETURN true;
    END;
$_$
LANGUAGE PLPGSQL;
