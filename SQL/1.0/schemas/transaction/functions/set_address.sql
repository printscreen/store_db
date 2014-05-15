DROP FUNCTION IF EXISTS set_address(
      i_address_id      BIGINT
    , i_street          CHARACTER VARYING
    , i_unit_number     CHARACTER VARYING
    , i_city            CHARACTER VARYING
    , i_state           CHARACTER VARYING
    , i_postal_code     CHARACTER VARYING
    , i_country_id      BIGINT
    , i_user_id         BIGINT
    , i_active          BOOLEAN
);

CREATE OR REPLACE FUNCTION set_address(
      i_address_id      BIGINT
    , i_street          CHARACTER VARYING
    , i_unit_number     CHARACTER VARYING
    , i_city            CHARACTER VARYING
    , i_state           CHARACTER VARYING
    , i_postal_code     CHARACTER VARYING
    , i_country_id      BIGINT
    , i_user_id         BIGINT
    , i_active          BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old transaction.address;
        v_id BIGINT;
        v_hash TEXT;
    BEGIN
	    v_hash := md5(lower(
                regexp_replace(
                    COALESCE(i_street, '') || COALESCE(i_unit_number, '') || COALESCE(i_city, '') || 
                    COALESCE(i_state, '') || COALESCE(i_postal_code, '') || COALESCE(i_country_id, 0),
                    E'[ \t\n\r]*'::TEXT,
                    ''::TEXT,
                    'g'::TEXT
                ))
            );
        SELECT * INTO v_old FROM transaction.address WHERE address_id = i_address_id;
        
        IF v_old.address_id IS NULL THEN
            --RAISE INFO '%', v_hash;
            SELECT * INTO v_old FROM transaction.address WHERE hash = v_hash;
        END IF;

        IF v_old.address_id IS NULL THEN
            INSERT INTO transaction.address (
                insert_ts
              , update_ts
              , street
              , unit_number
              , city
              , state
              , postal_code
              , country_id
              , user_id
              , active
              , hash
            ) VALUES (
                  NOW()
                , NOW() 
                , i_street
                , i_unit_number
                , i_city
                , i_state
                , i_postal_code
                , i_country_id
                , i_user_id
                , i_active
                , v_hash
            );

            v_id := CURRVAL('transaction.address_address_id_seq');
        ELSE
            UPDATE transaction.address SET
                update_ts = NOW()
              , street = COALESCE(i_street, street)
              , unit_number = COALESCE(i_unit_number, unit_number)
              , city = COALESCE(i_city, city)
              , state = COALESCE(i_state, state)
              , postal_code = COALESCE(i_postal_code, postal_code)
              , country_id = COALESCE(i_country_id, country_id)
              , user_id = COALESCE(i_user_id, user_id)
              , active = COALESCE(i_active, active)
              , hash = v_hash
            WHERE
                address_id = v_old.address_id;

            v_id := v_old.address_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
