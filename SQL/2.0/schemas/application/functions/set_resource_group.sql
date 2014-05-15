DROP FUNCTION IF EXISTS set_resource_group (
    i_resource_group_id BIGINT
  , i_name          VARCHAR(255)
  , i_description   TEXT
);
CREATE OR REPLACE FUNCTION set_resource_group (
    i_resource_group_id BIGINT
  , i_name          VARCHAR(255)
  , i_description   TEXT
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    DECLARE
        v_old application.resource_group;
        v_id BIGINT;
    BEGIN
        SELECT * INTO v_old FROM application.resource_group WHERE resource_group_id = i_resource_group_id;        

        IF v_old.resource_group_id IS NULL THEN
            INSERT INTO application.resource_group (
                name
              , description
            ) VALUES (
                i_name
              , i_description
            );

            v_id := CURRVAL('application.resource_group_resource_group_id_seq');
        ELSE
            UPDATE application.resource_group SET
                name = COALESCE(i_name, name)
              , description = COALESCE(i_description, description)
            WHERE
                resource_group_id = v_old.resource_group_id;

            v_id := v_old.resource_group_id;
        END IF;

        RETURN v_id;
    END;
$_$
LANGUAGE PLPGSQL;