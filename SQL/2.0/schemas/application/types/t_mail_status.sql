DROP TYPE IF EXISTS application.t_mail_status CASCADE;
CREATE TYPE application.t_mail_status AS (
    mail_status_id  BIGINT
  , name            VARCHAR(255)
  , total           BIGINT
);
ALTER TYPE application.t_mail_status OWNER TO store_db_su;