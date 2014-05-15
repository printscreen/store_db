DROP TABLE IF EXISTS application.mail CASCADE;
CREATE TABLE application.mail (
    mail_id         BIGSERIAL       PRIMARY KEY
  , name            VARCHAR(255)    NOT NULL UNIQUE
  , html_mail       TEXT            NOT NULL
  , plaintext_mail  TEXT            NOT NULL
  , insert_ts       TIMESTAMPTZ     DEFAULT NOW()
  , first_sent      TIMESTAMPTZ     NULL DEFAULT NULL
);
ALTER TABLE application.mail OWNER TO store_db_su;
