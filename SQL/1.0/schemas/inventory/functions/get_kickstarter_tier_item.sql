DROP FUNCTION IF EXISTS get_kickstarter_item_by_tier (
    i_kickstarter_tier_id   BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_item_by_tier (
    i_kickstarter_tier_id   BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF inventory.t_kickstarter_tier_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_kickstarter_tier_item;
    BEGIN
	    IF i_kickstarter_tier_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 kti.kickstarter_tier_item_id   AS kickstarter_tier_item_id
                ,kti.kickstarter_item_id        AS kickstarter_item_id
                ,kti.item_name                  AS item_name
                ,kti.item_description           AS item_description
                ,kti.is_physical_item           AS is_physical_item
                ,kti.kickstarter_tier_id        AS kickstarter_tier_id
                ,kti.tier_name                  AS tier_name
                ,kti.tier_description           AS tier_description
                ,kti.amount                     AS amount
                ,( SELECT COUNT(*)
                         FROM inventory.v_kickstarter_tier_item kti WHERE true '||COALESCE(' AND kti.kickstarter_tier_id='||i_kickstarter_tier_id, '')||'
                       )::BIGINT   AS total
            FROM inventory.v_kickstarter_tier_item kti
            WHERE TRUE'
            ||COALESCE(' AND kti.kickstarter_tier_id='||i_kickstarter_tier_id, '')||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_item_id        := REC.kickstarter_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.is_physical_item           := REC.is_physical_item;
            v_return.kickstarter_tier_id        := REC.kickstarter_tier_id;
            v_return.tier_name                  := REC.tier_name;
            v_return.tier_description           := REC.tier_description;
            v_return.amount                     := REC.amount;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;