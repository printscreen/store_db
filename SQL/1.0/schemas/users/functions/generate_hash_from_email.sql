DROP FUNCTION IF EXISTS generate_hash_from_email (
    i_email         VARCHAR(255)
);
CREATE OR REPLACE FUNCTION generate_hash_from_email  (
    i_email         VARCHAR(255)
)
RETURNS VARCHAR
SECURITY DEFINER AS
$_$
    DECLARE
        i_hash TEXT;
    BEGIN
        SELECT md5 (
            md5(
                NOW()::TEXT ||
                md5(
                    'With_my_last_breath_i_curse_Zoidberg!' ||
                    lower(trim(i_email)) ||
                    'With_my_last_breath_i_curse_Zoidberg!'
                ) ||
                NOW()::TEXT
            ) 
        )
        INTO i_hash;
        
        RETURN i_hash;
    END;
$_$
LANGUAGE PLPGSQL;