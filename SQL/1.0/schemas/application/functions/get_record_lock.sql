DROP FUNCTION IF EXISTS get_record_lock (
    i_record_lock_id    BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_record_lock (
    i_record_lock_id    BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF application.t_record_lock
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_record_lock;
    BEGIN
        v_sql := '
            SELECT 
                  rl.record_lock_id AS record_lock_id
                , rl.table_name     AS table_name
			    , rl.record_id      AS record_id
			    , rl.session_id     AS session_id
			    , rl.user_id        AS user_id
			    , rl.first_name     AS first_name
			    , rl.last_name      AS last_name
			    , rl.email          AS email
			    , rl.insert_ts      AS insert_ts
                ,( SELECT COUNT(*)
                         FROM application.v_record_lock rl WHERE true '|| COALESCE(' AND rl.record_lock_id='||i_record_lock_id, '') ||'
                       )::BIGINT       AS total
            FROM application.v_record_lock rl
            WHERE TRUE'
            || COALESCE(' AND rl.record_lock_id='||i_record_lock_id, '') || 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.record_lock_id             := REC.record_lock_id;
            v_return.table_name                 := REC.table_name;
            v_return.record_id                  := REC.record_id;
            v_return.session_id                 := REC.session_id;
            v_return.user_id                    := REC.user_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.email                      := REC.email;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_record_lock (
    i_record_lock_id    BIGINT
);
CREATE OR REPLACE FUNCTION get_record_lock (
    i_record_lock_id    BIGINT
)
RETURNS SETOF application.t_record_lock
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return application.t_record_lock;
    BEGIN
	    IF i_record_lock_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                  rl.record_lock_id AS record_lock_id
                , rl.table_name     AS table_name
                , rl.record_id      AS record_id
                , rl.session_id     AS session_id
                , rl.user_id        AS user_id
                , rl.first_name     AS first_name
                , rl.last_name      AS last_name
                , rl.email          AS email
                , rl.insert_ts      AS insert_ts
                , 1                 AS total
            FROM application.v_record_lock rl
            WHERE rl.record_lock_id='||i_record_lock_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.record_lock_id             := REC.record_lock_id;
            v_return.table_name                 := REC.table_name;
            v_return.record_id                  := REC.record_id;
            v_return.session_id                 := REC.session_id;
            v_return.user_id                    := REC.user_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.email                      := REC.email;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
