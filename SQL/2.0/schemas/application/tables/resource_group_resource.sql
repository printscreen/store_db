DROP TABLE IF EXISTS application.resource_group_resource CASCADE;
CREATE TABLE application.resource_group_resource (
    resource_group_resource_id  BIGSERIAL       PRIMARY KEY
  , resource_group_id           BIGINT          NOT NULL REFERENCES application.resource_group (resource_group_id)
  , resource_id                 BIGINT          NOT NULL REFERENCES application.resource (resource_id)
);
ALTER TABLE application.resource_group_resource OWNER TO store_db_su;
CREATE UNIQUE INDEX uc_resource_group_resource ON application.resource_group_resource (resource_group_id,resource_id);