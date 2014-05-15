DROP TABLE IF EXISTS transaction.order_postage_addon CASCADE;
CREATE TABLE transaction.order_postage_addon (
      order_postage_addon_id    BIGSERIAL       PRIMARY KEY
    , carrier_addon_id          BIGINT          NOT NULL REFERENCES transaction.carrier (carrier_id)
    , order_postage_id          BIGINT          NOT NULL REFERENCES transaction.order_postage (order_postage_id)
    , CONSTRAINT carrier_id_postage_id UNIQUE (carrier_addon_id,order_postage_id)
);
ALTER TABLE transaction.order_postage_addon OWNER TO store_db_su;
