DROP TABLE IF EXISTS transaction.postage_package_type CASCADE;
CREATE TABLE transaction.postage_package_type (
      postage_package_type_id   BIGSERIAL       PRIMARY KEY
    , name                      VARCHAR(255)    NOT NULL
);
ALTER TABLE transaction.postage_package_type OWNER TO store_db_su;
