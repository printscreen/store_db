DROP TABLE IF EXISTS inventory.sale_group CASCADE;
CREATE TABLE inventory.sale_group (
    sale_group_id   BIGSERIAL       PRIMARY KEY
  , name            VARCHAR(128)    NOT NULL
  , description     TEXT            NOT NULL
  , url             VARCHAR(255)    NOT NULL UNIQUE
  , insert_ts       TIMESTAMPTZ     NOT NULL
  , active          BOOLEAN         NOT NULL
);
ALTER TABLE inventory.sale_group OWNER TO store_db_su;
