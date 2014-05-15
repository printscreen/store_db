DROP FUNCTION IF EXISTS set_contact (
    i_contact_id        BIGINT
  , i_email             VARCHAR(255)
  , i_first_name        VARCHAR(255)
  , i_last_name         VARCHAR(255)
  , i_user_id           BIGINT
  , i_active            BOOLEAN
);
CREATE OR REPLACE FUNCTION set_contact (
    i_contact_id        BIGINT
  , i_email             VARCHAR(255)
  , i_first_name        VARCHAR(255)
  , i_last_name         VARCHAR(255)
  , i_user_id           BIGINT
  , i_active            BOOLEAN
)

RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.contact;
        v_find application.contact;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.contact WHERE contact_id = i_contact_id;
        
        -- Edge case where the user is changing their email to an email in the contact
        -- table that doesnt have a user associated to it. If this is the case, just
        -- delete the contact and let the user to associate themself to the email
        IF v_old.contact_id IS NULL THEN
            SELECT * INTO v_find FROM application.contact WHERE email = i_email;
            IF v_find.contact_id IS NOT NULL AND v_find.user_id IS NULL THEN
                DELETE FROM application.contact WHERE contact_id = v_find.contact_id;
            END IF;
        END IF;
        
        IF v_old.contact_id IS NULL THEN
            SELECT * INTO v_old FROM application.contact WHERE user_id = i_user_id;
        END IF;
        
        IF v_old.contact_id IS NULL THEN
            INSERT INTO application.contact (
                email
              , first_name
              , last_name
              , user_id
              , active
            ) VALUES (
                i_email
              , i_first_name
              , i_last_name
              , i_user_id
              , i_active
            );

            v_id := CURRVAL('application.contact_contact_id_seq');
        ELSE
            UPDATE application.contact SET
                email = COALESCE(i_email, email)
              , first_name = COALESCE(i_first_name, first_name)
              , last_name = COALESCE(i_last_name, last_name)
              , user_id = COALESCE(i_user_id, user_id)
              , active = COALESCE(i_active, active)
            WHERE
                contact_id = v_old.contact_id;

            v_id := v_old.contact_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;
