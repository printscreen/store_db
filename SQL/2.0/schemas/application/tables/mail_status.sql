DROP TABLE IF EXISTS application.mail_status CASCADE;
CREATE TABLE application.mail_status (
    mail_status_id  BIGSERIAL       PRIMARY KEY
  , name            VARCHAR(128)    NOT NULL
);
ALTER TABLE application.mail_status OWNER TO store_db_su;
