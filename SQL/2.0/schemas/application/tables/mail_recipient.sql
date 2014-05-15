DROP TABLE IF EXISTS application.mail_recipient CASCADE;
CREATE TABLE application.mail_recipient (
    mail_recipient_id   BIGSERIAL       PRIMARY KEY
  , mail_id             BIGINT          NOT NULL REFERENCES application.mail (mail_id)
  , contact_id          BIGINT          NOT NULL REFERENCES application.contact (contact_id)
  , mail_status_id      BIGINT          NOT NULL REFERENCES application.mail_status (mail_status_id)
  , send_on             TIMESTAMPTZ     NULL
);
ALTER TABLE application.mail_recipient OWNER TO store_db_su;
CREATE UNIQUE INDEX uc_mail_id_contact_id ON application.mail_recipient (mail_id,contact_id);