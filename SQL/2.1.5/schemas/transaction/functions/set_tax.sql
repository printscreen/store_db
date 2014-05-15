DROP FUNCTION IF EXISTS set_tax (
    i_tax_id        BIGINT
  , i_postal_code   BIGINT
  , i_rate          DOUBLE PRECISION
  , i_active        BOOLEAN
);
CREATE OR REPLACE FUNCTION set_tax (
    i_tax_id        BIGINT
  , i_postal_code   BIGINT
  , i_rate          DOUBLE PRECISION
  , i_active        BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.tax;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.tax WHERE tax_id = i_tax_id;

        IF v_old.tax_id IS NULL THEN
            INSERT INTO transaction.tax (
                  postal_code
                , rate
                , active
                , insert_ts
                , update_ts
            ) VALUES (
                  i_postal_code
                , i_rate
                , i_active
                , NOW()
                , NOW()
            );

            v_id := CURRVAL('transaction.tax_tax_id_seq');
        ELSE
            UPDATE transaction.tax SET
                  postal_code = COALESCE(i_postal_code, postal_code)
                , rate = COALESCE(i_rate, rate)
                , active = COALESCE(i_active, active)
                , update_ts = NOW()
            WHERE
                tax_id = v_old.tax_id;

            v_id := v_old.tax_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
