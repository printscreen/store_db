DROP VIEW IF EXISTS application.v_contact;
CREATE OR REPLACE VIEW application.v_contact AS
SELECT
    c.contact_id AS contact_id
  , c.email AS email
  , c.first_name AS first_name
  , c.last_name AS last_name
  , c.user_id AS user_id
  , c.active AS active
FROM application.contact c;
ALTER VIEW application.v_contact OWNER TO store_db_su;