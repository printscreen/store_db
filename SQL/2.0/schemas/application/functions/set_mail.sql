DROP FUNCTION IF EXISTS set_mail (
    i_mail_id           BIGINT
  , i_name              VARCHAR(255)
  , i_html_mail         TEXT
  , i_plaintext_mail    TEXT
  , i_first_sent        TIMESTAMPTZ
);
CREATE OR REPLACE FUNCTION set_mail (
    i_mail_id           BIGINT
  , i_name              VARCHAR(255)
  , i_html_mail         TEXT
  , i_plaintext_mail    TEXT
  , i_first_sent        TIMESTAMPTZ
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.mail;
        v_too_late_edit application.mail_recipient;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.mail WHERE mail_id = i_mail_id;
        SELECT * INTO v_too_late_edit FROM application.mail_recipient WHERE mail_id = i_mail_id AND mail_status_id > 2 LIMIT 1;
        
        IF v_old.mail_id IS NULL THEN
        
            INSERT INTO application.mail (
                name
              , html_mail
              , plaintext_mail
              , insert_ts
              , first_sent
            ) VALUES (
                i_name
              , i_html_mail
              , i_plaintext_mail
              , NOW()
              , i_first_sent
            );

            v_id := CURRVAL('application.mail_mail_id_seq');

        ELSIF v_old.mail_id IS NOT NULL AND v_too_late_edit.mail_recipient_id IS NULL THEN
            UPDATE application.mail SET
                name = COALESCE(i_name, name)
              , html_mail = COALESCE(i_html_mail, html_mail)
              , plaintext_mail = COALESCE(i_plaintext_mail, plaintext_mail)
              , first_sent = COALESCE(i_first_sent, first_sent)
            WHERE
                mail_id = v_old.mail_id;

            v_id := v_old.mail_id;
        ELSE
            RETURN 0;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
