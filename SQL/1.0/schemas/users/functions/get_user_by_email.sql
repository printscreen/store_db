DROP FUNCTION IF EXISTS get_user_by_email(
    i_email           VARCHAR
);
CREATE OR REPLACE FUNCTION get_user_by_email (
    i_email           VARCHAR
)
RETURNS SETOF users.t_user
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_user;
    BEGIN
        v_sql := '
            SELECT 
                 u.user_id              AS user_id
                ,u.insert_ts            AS insert_ts
                ,u.update_ts            AS update_ts
                ,u.first_name           AS first_name
                ,u.last_name            AS last_name
                ,u.email                AS email
                ,u.user_type_id         AS user_type_id
                ,u.user_type_name       AS user_type_name
                ,u.active               AS active
                ,( SELECT COUNT(*)
                         FROM users.v_user u WHERE true '|| COALESCE(' AND u.email='||quote_literal(i_email), '') ||'
                       )::BIGINT       AS total
            FROM users.v_user u
            WHERE TRUE'
            || COALESCE(' AND u.email='||quote_literal(i_email), '') || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.user_id                    := REC.user_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.email                      := REC.email;
            v_return.user_type_id               := REC.user_type_id;
            v_return.user_type_name             := REC.user_type_name;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
