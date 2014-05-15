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
    BEGIN        
        -- Some other user has laid claim to it
        SELECT * INTO REC FROM users.kickstarter WHERE kickstarter_id != i_kickstarter_id AND prefered_email = i_prefered_email;
        IF FOUND THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END;
$_$
LANGUAGE PLPGSQL;