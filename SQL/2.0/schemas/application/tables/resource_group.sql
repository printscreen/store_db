DROP TABLE IF EXISTS application.resource_group CASCADE;
CREATE TABLE application.resource_group (
    resource_group_id   BIGSERIAL       PRIMARY KEY
  , name                VARCHAR(255)    NOT NULL UNIQUE
  , description         TEXT            NULL
);
ALTER TABLE application.resource_group OWNER TO store_db_su;
