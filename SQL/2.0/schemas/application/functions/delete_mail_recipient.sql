DROP FUNCTION IF EXISTS delete_mail_recipient (
    i_mail_recipient_id   BIGINT
);
CREATE OR REPLACE FUNCTION delete_mail_recipient (
    i_mail_recipient_id   BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_find application.mail_recipient;
    BEGIN
        
        --Fine the record. If it hasnt been sent or in queue, you can delete it
        SELECT * INTO v_find FROM application.mail_recipient WHERE mail_recipient_id = i_mail_recipient_id;
        IF v_find.mail_recipient_id IS NULL OR v_find.mail_status_id > 2 THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM application.mail_recipient WHERE mail_recipient_id = i_mail_recipient_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS delete_mail_recipient (
    i_mail_recipient_ids   BIGINT[]
);
CREATE OR REPLACE FUNCTION delete_mail_recipient (
    i_mail_recipient_ids   BIGINT[]
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_find application.mail_recipient;
        i_mail_recipient_id BIGINT;
    BEGIN
        
	    FOR i_mail_recipient_id IN SELECT * FROM unnest(i_mail_recipient_ids) LOOP
	        --Fine the record. If it hasnt been sent or in queue, you can delete it
	        SELECT * INTO v_find FROM application.mail_recipient WHERE mail_recipient_id = i_mail_recipient_id;
	        IF v_find.mail_recipient_id IS NOT NULL AND v_find.mail_status_id < 3 THEN
	            DELETE FROM application.mail_recipient WHERE mail_recipient_id = i_mail_recipient_id;
	        END IF;
        END LOOP;
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
