DROP TYPE IF EXISTS application.t_mail CASCADE;
CREATE TYPE application.t_mail AS (
    mail_id         BIGINT
  , name            VARCHAR(255)
  , html_mail       TEXT
  , plaintext_mail  TEXT
  , insert_ts       TIMESTAMPTZ
  , first_sent      TIMESTAMPTZ
  , total           BIGINT
);
ALTER TYPE application.t_mail OWNER TO store_db_su;