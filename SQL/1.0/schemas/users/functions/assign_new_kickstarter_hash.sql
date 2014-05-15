DROP FUNCTION IF EXISTS assign_new_kickstarter_hash (
    i_kickstarter_id    BIGINT
);
CREATE OR REPLACE FUNCTION assign_new_kickstarter_hash  (
    i_kickstarter_id    BIGINT
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_find users.kickstarter;
    BEGIN
        SELECT * INTO v_find FROM users.kickstarter WHERE kickstarter_id = i_kickstarter_id;
        IF NOT FOUND THEN
            RETURN FALSE;
        END IF;
        
        UPDATE users.kickstarter
        SET hash = (SELECT * FROM generate_hash_from_email(v_find.email)), last_sent_hash = NOW()
        WHERE kickstarter_id = v_find.kickstarter_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;