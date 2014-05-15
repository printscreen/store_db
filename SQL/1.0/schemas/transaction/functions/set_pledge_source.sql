DROP FUNCTION IF EXISTS set_pledge_source(
      i_pledge_source_id    BIGINT
    , i_pledge_source_name  CHARACTER VARYING
);

CREATE OR REPLACE FUNCTION set_pledge_source(
      i_pledge_source_id    BIGINT
    , i_pledge_source_name  CHARACTER VARYING
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.pledge_source;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.pledge_source WHERE pledge_source_id = i_pledge_source_id;
        IF v_old.pledge_source_id IS NULL THEN
            SELECT * INTO v_old FROM transaction.pledge_source WHERE lower(name) = lower(trim(i_pledge_source_name));
        END IF;

        IF v_old.pledge_source_id IS NULL THEN
            INSERT INTO transaction.pledge_source (
                name
            ) VALUES (
                i_pledge_source_name 
            );

            v_id := CURRVAL('transaction.pledge_source_pledge_source_id_seq');
        ELSE
            UPDATE transaction.pledge_source SET
                name = COALESCE(i_pledge_source_name, name)
            WHERE
                pledge_source_id = v_old.pledge_source_id;

            v_id := v_old.pledge_source_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
