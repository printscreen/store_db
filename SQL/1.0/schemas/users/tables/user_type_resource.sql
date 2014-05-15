DROP TABLE IF EXISTS users.user_type_resource CASCADE;
CREATE TABLE users.user_type_resource (
    user_type_resource_id   BIGSERIAL       PRIMARY KEY
  , user_type_id            BIGINT          NOT NULL REFERENCES users.user_type (user_type_id)
  , resource_id             BIGINT          NOT NULL REFERENCES application.resource (resource_id)
);
ALTER TABLE users.user_type_resource OWNER TO store_db_su;
