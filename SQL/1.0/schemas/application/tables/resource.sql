DROP TABLE IF EXISTS application.resource CASCADE;
CREATE TABLE application.resource (
    resource_id       BIGSERIAL           PRIMARY KEY
  , name              VARCHAR(255)        NOT NULL
);
ALTER TABLE application.resource OWNER TO store_db_su;
