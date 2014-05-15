DROP FUNCTION IF EXISTS set_kickstarter (
    i_kickstarter_id  BIGINT
  , i_name            VARCHAR(255)
  , i_tier_id         BIGINT
  , i_first_name      VARCHAR(128)
  , i_last_name       VARCHAR(128)
  , i_email           VARCHAR(255)
  , i_prefered_email  VARCHAR(255)
  , i_password        VARCHAR(32)
  , i_street          VARCHAR(128)
  , i_unit_number     VARCHAR(128)
  , i_city            VARCHAR(128)
  , i_state           VARCHAR(128)
  , i_postal_code     VARCHAR(128)
  , i_country_id      BIGINT
  , i_phone_number    VARCHAR(100)
  , i_shirt_size      VARCHAR(4)
  , i_shirt_sex       VARCHAR(2)
  , i_notes           TEXT
  , i_last_sent_hash  TIMESTAMPTZ
  , i_verified        BOOLEAN
);
DROP FUNCTION IF EXISTS set_kickstarter (
    i_kickstarter_id  BIGINT
  , i_name            VARCHAR(255)
  , i_tier_id         BIGINT
  , i_first_name      VARCHAR(128)
  , i_last_name       VARCHAR(128)
  , i_email           VARCHAR(255)
  , i_prefered_email  VARCHAR(255)
  , i_user_id         BIGINT
  , i_order_id        BIGINT
  , i_address_id      BIGINT
  , i_password        VARCHAR(32)
  , i_street          VARCHAR(128)
  , i_unit_number     VARCHAR(128)
  , i_city            VARCHAR(128)
  , i_state           VARCHAR(128)
  , i_postal_code     VARCHAR(128)
  , i_country_id      BIGINT
  , i_phone_number    VARCHAR(100)
  , i_shirt_size      VARCHAR(4)
  , i_shirt_sex       VARCHAR(2)
  , i_notes           TEXT
  , i_last_sent_hash  TIMESTAMPTZ
  , i_verified        BOOLEAN
);
CREATE OR REPLACE FUNCTION set_kickstarter (
    i_kickstarter_id  BIGINT
  , i_name            VARCHAR(255)
  , i_tier_id         BIGINT
  , i_first_name      VARCHAR(128)
  , i_last_name       VARCHAR(128)
  , i_email           VARCHAR(255)
  , i_prefered_email  VARCHAR(255)
  , i_user_id         BIGINT
  , i_order_id        BIGINT
  , i_address_id      BIGINT
  , i_password        VARCHAR(32)
  , i_street          VARCHAR(128)
  , i_unit_number     VARCHAR(128)
  , i_city            VARCHAR(128)
  , i_state           VARCHAR(128)
  , i_postal_code     VARCHAR(128)
  , i_country_id      BIGINT
  , i_phone_number    VARCHAR(100)
  , i_shirt_size      VARCHAR(4)
  , i_shirt_sex       VARCHAR(2)
  , i_notes           TEXT
  , i_last_sent_hash  TIMESTAMPTZ
  , i_verified        BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old users.kickstarter;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM users.kickstarter WHERE kickstarter_id = i_kickstarter_id;
        IF v_old.kickstarter_id IS NULL THEN
            SELECT * INTO v_old FROM users.kickstarter WHERE email = lower(trim(i_email));
        END IF;
        
        IF v_old.kickstarter_id IS NULL THEN
            INSERT INTO users.kickstarter (
                name
              , tier_id
              , first_name
              , last_name
              , email
              , prefered_email
              , user_id
              , order_id
              , address_id
              , password
              , street
              , unit_number
              , city
              , state
              , postal_code
              , country_id
              , phone_number
              , shirt_size
              , shirt_sex
              , notes
              , hash
              , update_ts
            ) VALUES (
                trim(i_name)
              , i_tier_id
              , initcap(trim(i_first_name))
              , initcap(trim(i_last_name))
              , lower(trim(i_email))
              , lower(trim(i_prefered_email))
              , i_user_id
              , i_order_id
              , i_address_id
              , (SELECT * FROM hash_password(i_password))
              , i_street
              , i_unit_number
              , i_city
              , i_state
              , i_postal_code
              , i_country_id
              , i_phone_number
              , i_shirt_size
              , i_shirt_sex
              , i_notes
              , (SELECT * FROM generate_hash_from_email(i_email))
              , NOW()
            );

            v_id := CURRVAL('users.kickstarter_kickstarter_id_seq');
        ELSE
            UPDATE users.kickstarter SET
                name = COALESCE(trim(i_name), name)
              , tier_id = COALESCE(i_tier_id, tier_id)
              , first_name = COALESCE(initcap(trim(i_first_name)), first_name)
              , last_name = COALESCE(initcap(trim(i_last_name)), last_name)
              , email = COALESCE(lower(trim(i_email)), email)
              , prefered_email = COALESCE(lower(trim(i_prefered_email)), prefered_email)
              , user_id = COALESCE(i_user_id, user_id)
              , order_id = COALESCE(i_order_id, order_id)
              , address_id = COALESCE(i_address_id, address_id)
              , password = COALESCE((SELECT * FROM hash_password(i_password)), password)
              , street = COALESCE(i_street, street)
              , unit_number = COALESCE(i_unit_number, unit_number)
              , city = COALESCE(i_city, city)
              , state = COALESCE(i_state, state)
              , postal_code = COALESCE(i_postal_code, postal_code)
              , country_id = COALESCE(i_country_id, country_id)
              , phone_number = COALESCE(i_phone_number, phone_number)
              , shirt_size = COALESCE(i_shirt_size, shirt_size)
              , notes = COALESCE(i_notes, notes)
              , shirt_sex = COALESCE(i_shirt_sex, shirt_sex)
              , last_sent_hash = COALESCE(i_last_sent_hash, last_sent_hash)
              , verified = COALESCE(i_verified, verified)
              , update_ts = NOW()
            WHERE
                kickstarter_id = v_old.kickstarter_id;

            v_id := v_old.kickstarter_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
