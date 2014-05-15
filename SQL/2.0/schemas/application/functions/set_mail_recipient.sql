DROP FUNCTION IF EXISTS set_mail_recipient (
    i_mail_recipient_id BIGINT
  , i_mail_id           BIGINT
  , i_contact_id        BIGINT
  , i_mail_status_id    BIGINT
  , i_send_on           TIMESTAMPTZ
);
CREATE OR REPLACE FUNCTION set_mail_recipient (
    i_mail_recipient_id BIGINT
  , i_mail_id           BIGINT
  , i_contact_id        BIGINT
  , i_mail_status_id    BIGINT
  , i_send_on           TIMESTAMPTZ
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.mail_recipient;
        v_id BIGINT;
        v_mail_id BIGINT;
        v_find application.mail_recipient;
    BEGIN
        SELECT * INTO v_old FROM application.mail_recipient WHERE mail_recipient_id = i_mail_recipient_id;
        
        IF v_old.mail_recipient_id IS NULL THEN
        
            INSERT INTO application.mail_recipient (
                mail_id
              , contact_id
              , mail_status_id
              , send_on
            ) VALUES (
                i_mail_id
              , i_contact_id
              , i_mail_status_id
              , i_send_on
            );

            v_id := CURRVAL('application.mail_recipient_mail_recipient_id_seq');

        ELSE 
            UPDATE application.mail_recipient SET
                mail_status_id = COALESCE(i_mail_status_id, mail_status_id)
              , send_on = COALESCE(i_send_on, send_on)
            WHERE
                mail_recipient_id = v_old.mail_recipient_id;

            v_id := v_old.mail_recipient_id;
        END IF;
        v_mail_id = COALESCE(i_mail_id, v_old.mail_id);
        --If this message is being sent, and it is the first one, update
        --first sent field in the mail table
        IF i_mail_status_id > 2 AND v_mail_id IS NOT NULL THEN
            SELECT * INTO v_find 
            FROM application.mail_recipient 
            WHERE mail_id = i_mail_id 
            AND mail_recipient_id != v_id
            AND mail_status_id > 2
            LIMIT 1;
            IF v_find.mail_recipient_id IS NULL THEN
                UPDATE application.mail SET first_sent = NOW() WHERE mail_id = v_mail_id;
            END IF;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS set_mail_recipient (
    i_mail_recipient_id BIGINT
  , i_mail_id           BIGINT
  , i_contact_ids       BIGINT[]
  , i_mail_status_id    BIGINT
  , i_send_on           TIMESTAMPTZ
);
CREATE OR REPLACE FUNCTION set_mail_recipient (
    i_mail_recipient_id BIGINT
  , i_mail_id           BIGINT
  , i_contact_ids       BIGINT[]
  , i_mail_status_id    BIGINT
  , i_send_on           TIMESTAMPTZ
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.mail_recipient;
        v_id BIGINT;
        v_mail_id BIGINT;
        v_find application.mail_recipient;
        i_contact_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.mail_recipient WHERE mail_recipient_id = i_mail_recipient_id;
        
        FOR i_contact_id IN SELECT * FROM unnest(i_contact_ids) LOOP
	        IF v_old.mail_recipient_id IS NULL THEN
	        
	            INSERT INTO application.mail_recipient (
	                mail_id
	              , contact_id
	              , mail_status_id
	              , send_on
	            ) VALUES (
	                i_mail_id
	              , i_contact_id
	              , i_mail_status_id
	              , i_send_on
	            );
	
	            v_id := CURRVAL('application.mail_recipient_mail_recipient_id_seq');
	
	        ELSE 
	            UPDATE application.mail_recipient SET
	                mail_status_id = COALESCE(i_mail_status_id, mail_status_id)
	              , send_on = COALESCE(i_send_on, send_on)
	            WHERE
	                mail_recipient_id = v_old.mail_recipient_id;
	
	            v_id := v_old.mail_recipient_id;
	        END IF;
	        v_mail_id = COALESCE(i_mail_id, v_old.mail_id);
	        --If this message is being sent, and it is the first one, update
	        --first sent field in the mail table
	        IF i_mail_status_id > 2 AND v_mail_id IS NOT NULL THEN
	            SELECT * INTO v_find 
	            FROM application.mail_recipient 
	            WHERE mail_id = i_mail_id 
	            AND mail_recipient_id != v_id
	            AND mail_status_id > 2
	            LIMIT 1;
	            IF v_find.mail_recipient_id IS NULL THEN
	                UPDATE application.mail SET first_sent = NOW() WHERE mail_id = v_mail_id;
	            END IF;
	        END IF;
        END LOOP;
        RETURN true;
    END;
$_$
LANGUAGE PLPGSQL;

