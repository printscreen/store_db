DROP FUNCTION IF EXISTS set_user_type_resource (
    i_user_type_id      BIGINT
  , i_resource_group_id BIGINT
);
CREATE OR REPLACE FUNCTION set_user_type_resource (
    i_user_type_id      BIGINT
  , i_resource_group_id BIGINT
)
RETURNS BOOLEAN
SECURITY DEFINER AS
$_$
    DECLARE
        v_resource application.resource_group_resource;
        v_user_type users.user_type;
        v_find users.user_type_resource;
        REC RECORD;
    BEGIN
        SELECT * INTO v_resource FROM application.resource_group_resource WHERE resource_group_id = i_resource_group_id LIMIT 1;
        IF v_resource.resource_group_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        SELECT * INTO v_user_type FROM users.user_type WHERE user_type_id = i_user_type_id;
        IF v_user_type.user_type_id IS NULL THEN
            RETURN FALSE;
        END IF;
        
        FOR REC IN SELECT * FROM application.resource_group_resource WHERE resource_group_id = i_resource_group_id
        LOOP
            SELECT * INTO v_find FROM users.user_type_resource WHERE resource_id = REC.resource_id AND user_type_id = i_user_type_id;
            IF v_find.user_type_resource_id IS NULL THEN
                INSERT INTO users.user_type_resource (user_type_id,resource_id) VALUES (i_user_type_id,REC.resource_id);
            END IF;
        END LOOP;
       RETURN TRUE;
    END;
$_$
LANGUAGE PLPGSQL;
