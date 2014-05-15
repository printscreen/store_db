DROP FUNCTION IF EXISTS hash_password (
    i_password       VARCHAR(255)
);
CREATE OR REPLACE FUNCTION hash_password  (
    i_password       VARCHAR(255)
)
RETURNS VARCHAR
SECURITY DEFINER AS
$_$
    DECLARE
        i_hash TEXT;
    BEGIN
	    IF i_password IS NULL OR length(i_password) < 1 THEN
	       RETURN NULL;
	    END IF;
	    
        SELECT md5 (
            md5(
                'Shut_up_and_take_my_money!' ||
                md5(
                    'With_my_last_breath_i_curse_Zoidberg!' ||
                    trim(i_password) ||
                    'With_my_last_breath_i_curse_Zoidberg!'
                ) ||
                'Shut_up_and_take_my_money!'
            ) 
        )
        INTO i_hash;
        
        RETURN i_hash;
    END;
$_$
LANGUAGE PLPGSQL;