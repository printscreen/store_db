DROP TYPE IF EXISTS transaction.t_order_postage_customs_content_type CASCADE;
CREATE TYPE transaction.t_order_postage_customs_content_type AS (
    order_postage_customs_content_type_id   BIGINT
  , name                                    VARCHAR(255)
  , total                                   BIGINT
);
ALTER TYPE transaction.t_order_postage_customs_content_type  OWNER TO store_db_su;