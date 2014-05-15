DROP FUNCTION IF EXISTS clear_record_lock (
    i_user_id           BIGINT
  , i_session_id        VARCHAR(255)
);
CREATE OR REPLACE FUNCTION clear_record_lock (
    i_user_id           BIGINT
  , i_session_id        VARCHAR(255)
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    BEGIN        
        DELETE FROM application.record_lock WHERE user_id = i_user_id;
        DELETE FROM application.record_lock WHERE session_id = i_session_id;
        
        RETURN true;
    END;
$_$
LANGUAGE PLPGSQL;
