DROP TYPE IF EXISTS application.t_resource_group CASCADE;
CREATE TYPE application.t_resource_group AS (
    resource_group_id   BIGINT
  , name                VARCHAR(255)
  , description         TEXT
  , total               BIGINT
);
ALTER TYPE application.t_resource_group OWNER TO store_db_su;