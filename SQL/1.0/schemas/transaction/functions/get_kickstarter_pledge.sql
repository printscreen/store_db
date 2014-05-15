DROP FUNCTION IF EXISTS get_kickstarter_pledge (
    i_kickstarter_id    BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_pledge (
    i_kickstarter_id    BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_kickstarter_pledge
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_kickstarter_pledge;
    BEGIN
        v_sql := '
            SELECT 
                 kp.kickstarter_pledge_id   AS kickstarter_pledge_id
                ,kp.kickstarter_id          AS kickstarter_id
                ,kp.amount                  AS amount
                ,kp.transaction_id          AS transaction_id
                ,kp.pledge_source_id        AS pledge_source_id
                ,kp.pledge_source_name      AS pledge_source_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_kickstarter_pledge kp WHERE true '|| COALESCE(' AND kp.kickstarter_id='||i_kickstarter_id, '') ||'
                       )::BIGINT            AS total
            FROM transaction.v_kickstarter_pledge kp
            WHERE true '|| COALESCE(' AND kp.kickstarter_id='||i_kickstarter_id, '') ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_pledge_id      := REC.kickstarter_pledge_id;
            v_return.kickstarter_id             := REC.kickstarter_id;
            v_return.amount                     := REC.amount;
            v_return.transaction_id             := REC.transaction_id;
            v_return.pledge_source_id           := REC.pledge_source_id;
            v_return.pledge_source_name         := REC.pledge_source_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_kickstarter_pledge (
    i_kickstarter_pledge_id    BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_pledge (
    i_kickstarter_pledge_id    BIGINT
)
RETURNS SETOF transaction.t_kickstarter_pledge
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_kickstarter_pledge;
    BEGIN
        v_sql := '
            SELECT 
                 kp.kickstarter_pledge_id   AS kickstarter_pledge_id
                ,kp.kickstarter_id          AS kickstarter_id
                ,kp.amount                  AS amount
                ,kp.transaction_id          AS transaction_id
                ,kp.pledge_source_id        AS pledge_source_id
                ,kp.pledge_source_name      AS pledge_source_name
                ,1                          AS total
            FROM transaction.v_kickstarter_pledge kp
            WHERE kp.kickstarter_pledge_id='|| i_kickstarter_pledge_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_pledge_id      := REC.kickstarter_pledge_id;
            v_return.kickstarter_id             := REC.kickstarter_id;
            v_return.amount                     := REC.amount;
            v_return.transaction_id             := REC.transaction_id;
            v_return.pledge_source_id           := REC.pledge_source_id;
            v_return.pledge_source_name         := REC.pledge_source_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_kickstarter_pledge (
    i_transaction_id    TEXT
);
CREATE OR REPLACE FUNCTION get_kickstarter_pledge (
    i_transaction_id    TEXT
)
RETURNS SETOF transaction.t_kickstarter_pledge
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_kickstarter_pledge;
    BEGIN
        v_sql := '
            SELECT 
                 kp.kickstarter_pledge_id   AS kickstarter_pledge_id
                ,kp.kickstarter_id          AS kickstarter_id
                ,kp.amount                  AS amount
                ,kp.transaction_id          AS transaction_id
                ,kp.pledge_source_id        AS pledge_source_id
                ,kp.pledge_source_name      AS pledge_source_name
                ,1                          AS total
            FROM transaction.v_kickstarter_pledge kp
            WHERE kp.transaction_id='||quote_literal(i_transaction_id) || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_pledge_id      := REC.kickstarter_pledge_id;
            v_return.kickstarter_id             := REC.kickstarter_id;
            v_return.amount                     := REC.amount;
            v_return.transaction_id             := REC.transaction_id;
            v_return.pledge_source_id           := REC.pledge_source_id;
            v_return.pledge_source_name         := REC.pledge_source_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;