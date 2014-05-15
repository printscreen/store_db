DROP TABLE IF EXISTS transaction.order_postage_customs_content_type CASCADE;
CREATE TABLE transaction.order_postage_customs_content_type (
    order_postage_customs_content_type_id   BIGSERIAL       PRIMARY KEY
  , name                                    VARCHAR(255)    NOT NULL UNIQUE
);
ALTER TABLE transaction.order_postage_customs_content_type OWNER TO store_db_su;