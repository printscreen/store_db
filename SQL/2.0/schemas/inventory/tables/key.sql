DROP TABLE IF EXISTS inventory.key CASCADE;
CREATE TABLE inventory.key (
    key_id                  BIGSERIAL       PRIMARY KEY
  , key                     TEXT            NOT NULL
  , item_id                 BIGINT          NOT NULL REFERENCES inventory.item (item_id)
  , user_id                 BIGINT          NOT NULL REFERENCES users.user (user_id)
  , insert_ts               TIMESTAMPTZ     NOT NULL
);
ALTER TABLE inventory.key OWNER TO store_db_su;
CREATE UNIQUE INDEX uc_item_id_key ON inventory.key (item_id,key);