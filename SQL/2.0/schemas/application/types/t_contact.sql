DROP TYPE IF EXISTS application.t_contact CASCADE;
CREATE TYPE application.t_contact AS (
    contact_id      BIGINT
  , email           VARCHAR(255)
  , first_name      VARCHAR(255)
  , last_name       VARCHAR(255)
  , user_id         BIGINT
  , active          BOOLEAN
  , total           BIGINT
);
ALTER TYPE application.t_contact OWNER TO store_db_su;