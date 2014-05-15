DROP FUNCTION IF EXISTS delete_mail (
    i_mail_id   BIGINT
);
CREATE OR REPLACE FUNCTION delete_mail (
    i_mail_id   BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.mail;
        v_find application.mail_recipient;
    BEGIN
	    -- Find the record
        SELECT * INTO v_old FROM application.mail WHERE mail_id = i_mail_id;
        IF v_old.mail_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        --A mail must have no recipients before it can be deleted | Prevent deleteion of mails already sent
        SELECT * INTO v_find FROM application.mail_recipient WHERE mail_id = i_mail_id LIMIT 1;
        IF v_find.mail_recipient_id IS NOT NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM application.mail WHERE mail_id = i_mail_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
