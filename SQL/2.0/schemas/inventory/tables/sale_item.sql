DROP TABLE IF EXISTS inventory.sale_item CASCADE;
CREATE TABLE inventory.sale_item (
    sale_item_id    BIGSERIAL       PRIMARY KEY
  , name            VARCHAR(128)    NOT NULL
  , description     TEXT            NOT NULL
  , price           BIGINT          NOT NULL
  , insert_ts       TIMESTAMPTZ     DEFAULT NOW()
  , active          BOOLEAN
);
ALTER TABLE inventory.sale_item OWNER TO store_db_su;
