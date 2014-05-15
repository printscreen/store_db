DROP TYPE IF EXISTS application.t_mail_recipient CASCADE;
CREATE TYPE application.t_mail_recipient AS (
    mail_recipient_id   BIGINT
  , mail_id             BIGINT
  , contact_id          BIGINT
  , email               VARCHAR(255)
  , first_name          VARCHAR(255)
  , last_name           VARCHAR(255)
  , user_id             BIGINT
  , mail_status_id      BIGINT
  , mail_status_name    VARCHAR(128)
  , send_on             TIMESTAMPTZ
  , total               BIGINT
);
ALTER TYPE application.t_mail_recipient OWNER TO store_db_su;