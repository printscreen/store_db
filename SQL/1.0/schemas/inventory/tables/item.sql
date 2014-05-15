DROP TABLE IF EXISTS inventory.item CASCADE;
CREATE TABLE inventory.item (
    item_id         BIGSERIAL       PRIMARY KEY
  , code            VARCHAR(128)    NOT NULL
  , name            VARCHAR(128)    NOT NULL
  , description     TEXT            NOT NULL
  , weight_ounces   BIGINT          NULL
  , active          BOOLEAN
);
ALTER TABLE inventory.item OWNER TO store_db_su;
