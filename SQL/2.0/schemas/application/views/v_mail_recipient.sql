DROP VIEW IF EXISTS application.v_mail_recipient;
CREATE OR REPLACE VIEW application.v_mail_recipient AS
SELECT
    mr.mail_recipient_id AS mail_recipient_id
  , mr.mail_id AS mail_id
  , mr.contact_id AS contact_id
  , c.email AS email
  , c.user_id AS user_id
  , c.first_name AS first_name
  , c.last_name AS last_name
  , mr.mail_status_id AS mail_status_id
  , ms.name AS mail_status_name
  , mr.send_on AS send_on
FROM application.mail_recipient mr
INNER JOIN application.mail_status ms on mr.mail_status_id = ms.mail_status_id
INNER JOIN application.contact c ON c.contact_id = mr.contact_id;
ALTER VIEW application.v_mail_recipient OWNER TO store_db_su;