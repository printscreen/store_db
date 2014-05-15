DROP FUNCTION IF EXISTS set_kickstarter_pledge (
    i_kickstarter_pledge_id     BIGINT
  , i_kickstarter_id            BIGINT
  , i_amount                    BIGINT
  , i_transaction_id            TEXT
  , i_pledge_source_id          BIGINT
);
CREATE OR REPLACE FUNCTION set_kickstarter_pledge (
    i_kickstarter_pledge_id     BIGINT
  , i_kickstarter_id            BIGINT
  , i_amount                    BIGINT
  , i_transaction_id            TEXT
  , i_pledge_source_id          BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.kickstarter_pledge;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM transaction.kickstarter_pledge WHERE kickstarter_pledge_id = i_kickstarter_pledge_id;
        IF v_old.kickstarter_pledge_id IS NULL THEN
            SELECT * INTO v_old FROM transaction.kickstarter_pledge WHERE transaction_id = trim(i_transaction_id) AND kickstarter_id = i_kickstarter_id;
        END IF;
        
        IF v_old.kickstarter_pledge_id IS NULL THEN
            INSERT INTO transaction.kickstarter_pledge (
                kickstarter_id
              , amount
              , transaction_id
              , pledge_source_id
            ) VALUES (
                i_kickstarter_id
              , i_amount
              , i_transaction_id
              , i_pledge_source_id
            );

            v_id := CURRVAL('transaction.kickstarter_pledge_kickstarter_pledge_id_seq');
        ELSE
            UPDATE transaction.kickstarter_pledge SET
                kickstarter_id = COALESCE(i_kickstarter_id, kickstarter_id)
              , amount = COALESCE(i_amount, amount)
              , transaction_id = COALESCE(i_transaction_id, transaction_id)
              , pledge_source_id = COALESCE(i_pledge_source_id, pledge_source_id)
            WHERE
                kickstarter_pledge_id = v_old.kickstarter_pledge_id;

            v_id := v_old.kickstarter_pledge_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
