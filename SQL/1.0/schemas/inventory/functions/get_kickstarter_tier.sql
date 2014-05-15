DROP FUNCTION IF EXISTS get_kickstarter_tier (
    i_kickstarter_tier_id   BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_tier (
    i_kickstarter_tier_id   BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF inventory.t_kickstarter_tier
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_kickstarter_tier;
    BEGIN
        v_sql := '
            SELECT 
                 kt.kickstarter_tier_id AS kickstarter_tier_id
                ,kt.amount              AS amount
                ,kt.tier_name           AS tier_name
                ,kt.description         AS description
                ,( SELECT COUNT(*)
                         FROM inventory.v_kickstarter_tier kt WHERE true '||COALESCE(' AND i.kickstarter_tier_id='||i_kickstarter_tier_id, '')||'
                       )::BIGINT   AS total
            FROM inventory.v_kickstarter_tier kt
            WHERE TRUE'
            ||COALESCE(' AND i.kickstarter_tier_id='||i_kickstarter_tier_id, '')||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_tier_id    := REC.kickstarter_tier_id;
            v_return.amount                 := REC.amount;
            v_return.tier_name              := REC.tier_name;
            v_return.description            := REC.description;
            v_return.total                  := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_kickstarter_tier (
    i_kickstarter_tier_id   BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_tier (
    i_kickstarter_tier_id   BIGINT
)
RETURNS SETOF inventory.t_kickstarter_tier
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_kickstarter_tier;
    BEGIN
        IF i_kickstarter_tier_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 kt.kickstarter_tier_id AS kickstarter_tier_id
                ,kt.amount              AS amount
                ,kt.tier_name           AS tier_name
                ,kt.description         AS description
                ,1                      AS total
            FROM inventory.v_kickstarter_tier kt
            WHERE kt.kickstarter_tier_id='||i_kickstarter_tier_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_tier_id    := REC.kickstarter_tier_id;
            v_return.amount                 := REC.amount;
            v_return.tier_name              := REC.tier_name;
            v_return.description            := REC.description;
            v_return.total                  := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
