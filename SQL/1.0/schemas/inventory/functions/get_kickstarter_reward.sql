DROP FUNCTION IF EXISTS get_kickstarter_reward (
    i_amount                INTEGER
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_reward (
    i_amount                INTEGER
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF inventory.t_kickstarter_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_kickstarter_item;
    BEGIN
	    IF i_amount IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 ki.kickstarter_item_id     AS kickstater_item_id
                ,ki.item_name               AS item_name
                ,ki.description             AS description
                ,ki.kickstarter_tier_id     AS kickstarter_tier_id
                ,ki.kickstarter_tier_name   AS kickstarter_tier_name
                ,ki.kickstarter_tier_amount AS kickstarter_tier_amount
                ,( SELECT COUNT(*)
                         FROM inventory.v_kickstarter_item ki WHERE  ki.kickstarter_tier_amount <='||i_amount||'
                       )::BIGINT   AS total
            FROM inventory.v_kickstarter_item ki
            WHERE  ki.kickstarter_tier_amount <='||i_amount||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_item_id        := REC.kickstarter_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.description                := REC.description;
            v_return.kickstarter_tier_id        := REC.kickstarter_tier_id;
            v_return.kickstarter_tier_name      := REC.kickstarter_tier_name;
            v_return.kickstarter_tier_amount    := REC.kickstarter_tier_amount;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;