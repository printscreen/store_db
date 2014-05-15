DROP FUNCTION IF EXISTS set_order_shipping(
      i_order_shipping_id   BIGINT
    , i_order_id            BIGINT
    , i_address_id          BIGINT
    , i_first_name          CHARACTER VARYING
    , i_last_name           CHARACTER VARYING
    , i_shipping_cost       BIGINT
);