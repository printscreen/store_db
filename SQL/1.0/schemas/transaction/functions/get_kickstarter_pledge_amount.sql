DROP FUNCTION IF EXISTS get_kickstarter_pledge_amount(
    i_kickstarter_id    BIGINT
);

CREATE OR REPLACE FUNCTION get_kickstarter_pledge_amount(
    i_kickstarter_id    BIGINT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_total BIGINT;
    BEGIN
	    
	    IF i_kickstarter_id IS NULL THEN
	       SELECT sum(amount) INTO v_total FROM transaction.kickstarter_pledge;
	    ELSE
	       SELECT sum(amount) INTO v_total FROM transaction.kickstarter_pledge WHERE kickstarter_id = i_kickstarter_id;
	    END IF;

        RETURN v_total;
    END;
$_$
LANGUAGE PLPGSQL;
