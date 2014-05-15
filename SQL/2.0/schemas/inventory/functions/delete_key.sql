DROP FUNCTION IF EXISTS delete_key (
    i_key_id   BIGINT
);
CREATE OR REPLACE FUNCTION delete_key (
    i_key_id   BIGINT
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_old inventory.key;
    BEGIN
        SELECT * INTO v_old FROM inventory.key WHERE key_id = i_key_id;
        IF v_old.key_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        DELETE FROM inventory.key WHERE key_id = i_key_id;
        
        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS delete_key (
    i_key_ids   BIGINT[]
);
CREATE OR REPLACE FUNCTION delete_key (
    i_key_ids   BIGINT[]
)

RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_find inventory.key;
        i_key_id BIGINT;
    BEGIN
	    
        DELETE FROM inventory.key WHERE key_id IN (SELECT unnest(i_key_ids));

        RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
