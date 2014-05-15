DROP VIEW IF EXISTS application.v_mail;
CREATE OR REPLACE VIEW application.v_mail AS
SELECT
    m.mail_id AS mail_id
  , m.name AS name
  , m.html_mail AS html_mail
  , m.plaintext_mail AS plaintext_mail
  , m.insert_ts AS insert_ts
  , m.first_sent AS first_sent
FROM application.mail m;
ALTER VIEW application.v_mail OWNER TO store_db_su;