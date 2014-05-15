DROP FUNCTION IF EXISTS set_user (
    i_user_id       BIGINT
  , i_first_name    VARCHAR(128)
  , i_last_name     VARCHAR(128)
  , i_email         VARCHAR(255)
  , i_password      VARCHAR(32)
  , i_user_type_id  BIGINT
  , i_active        BOOLEAN
);
DROP FUNCTION IF EXISTS set_user (
    i_user_id       BIGINT
  , i_first_name    VARCHAR(128)
  , i_last_name     VARCHAR(128)
  , i_email         VARCHAR(255)
  , i_password      VARCHAR(32)
  , i_user_type_id  BIGINT
  , i_stripe_id     VARCHAR(32)
  , i_active        BOOLEAN
  , i_verified      BOOLEAN
);
CREATE OR REPLACE FUNCTION set_user (
    i_user_id       BIGINT
  , i_first_name    VARCHAR(128)
  , i_last_name     VARCHAR(128)
  , i_email         VARCHAR(255)
  , i_password      VARCHAR(32)
  , i_user_type_id  BIGINT
  , i_stripe_id     VARCHAR(32)
  , i_active        BOOLEAN
  , i_verified      BOOLEAN
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old users.user;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM users.user WHERE user_id = i_user_id;
        IF v_old.user_id IS NULL THEN
            SELECT * INTO v_old FROM users.user WHERE email = lower(i_email);
        END IF;
        

        IF v_old.user_id IS NULL THEN
            INSERT INTO users.user (
                first_name
              , last_name
              , email
              , password
              , user_type_id
              , stripe_id  
              , active
              , verified
              , update_ts
            ) VALUES (
                initcap(trim(i_first_name))
              , initcap(trim(i_last_name))
              , lower(trim(i_email))
              , (SELECT * FROM hash_password(i_password))
              , i_user_type_id
              , i_stripe_id
              , i_active
              , i_verified
              , NOW()
            );

            v_id := CURRVAL('users.user_user_id_seq');
        ELSE
            UPDATE users.user SET
                first_name = COALESCE(initcap(trim(i_first_name)), first_name)
              , last_name = COALESCE(initcap(trim(i_last_name)), last_name)
              , email = COALESCE(lower(trim(i_email)), email)
              , password = COALESCE((SELECT * FROM hash_password(i_password)), password)
              , user_type_id = COALESCE(i_user_type_id, user_type_id)
              , stripe_id = COALESCE(i_stripe_id, stripe_id)
              , active = COALESCE(i_active, active)
              , verified = COALESCE(i_verified, verified)
              , update_ts = NOW()
            WHERE
                user_id = v_old.user_id;

            v_id := v_old.user_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
