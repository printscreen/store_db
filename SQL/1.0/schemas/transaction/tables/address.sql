DROP TABLE IF EXISTS transaction.address CASCADE;
CREATE TABLE transaction.address (
    address_id      BIGSERIAL       PRIMARY KEY
  , insert_ts       TIMESTAMPTZ     NOT NULL DEFAULT NOW()
  , update_ts       TIMESTAMPTZ
  , street          VARCHAR(128)    NOT NULL
  , unit_number     VARCHAR(128)    DEFAULT NULL
  , city            VARCHAR(128)    NOT NULL
  , state           VARCHAR(128)    NOT NULL
  , postal_code     VARCHAR(128)    NOT NULL
  , country_id      BIGINT          NOT NULL REFERENCES transaction.country (country_id)
  , user_id         BIGINT          NOT NULL REFERENCES users.user (user_id)
  , active          BOOLEAN         NOT NULL DEFAULT FALSE
  , hash            VARCHAR(255)    NOT NULL
);
ALTER TABLE transaction.address OWNER TO store_db_su;
