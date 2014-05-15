DROP VIEW IF EXISTS application.v_mail_status CASCADE;
CREATE OR REPLACE VIEW application.v_mail_status AS
SELECT
     ms.mail_status_id AS mail_status_id
   , ms.name AS name
FROM application.mail_status ms;
ALTER VIEW application.v_mail_status OWNER TO store_db_su;
