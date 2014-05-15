DROP FUNCTION IF EXISTS set_order_billing(
      i_order_billing_id        BIGINT
    , i_order_id                BIGINT
    , i_address_id              BIGINT
    , i_first_name              CHARACTER VARYING
    , i_last_name               CHARACTER VARYING
    , i_authorization_number    CHARACTER VARYING
);