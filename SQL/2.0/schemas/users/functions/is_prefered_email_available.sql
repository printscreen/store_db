DROP FUNCTION IF EXISTS is_prefered_email_available (
      i_kickstarter_id    BIGINT
    , i_prefered_email    VARCHAR(255)
);
CREATE OR REPLACE FUNCTION is_prefered_email_available  (
      i_kickstarter_id    BIGINT
    , i_prefered_email    VARCHAR(255)
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_kick users.kickstarter;
        v_user users.user;
    BEGIN        
        -- Some other user has laid claim to it
        SELECT * INTO REC FROM users.kickstarter WHERE kickstarter_id != i_kickstarter_id AND prefered_email = i_prefered_email;
        IF FOUND THEN
            RETURN FALSE;
        ELSE
            SELECT * INTO v_kick FROM users.kickstarter WHERE kickstarter_id = i_kickstarter_id;
            SELECT * INTO v_user FROM users.user WHERE email = i_prefered_email;
            IF v_kick.user_id != v_user.user_id THEN
                RETURN FALSE;
            END IF; 
            RETURN TRUE;
        END IF;
    END;
$_$
LANGUAGE PLPGSQL;