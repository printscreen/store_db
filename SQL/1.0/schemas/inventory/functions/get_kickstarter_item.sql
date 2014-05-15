DROP FUNCTION IF EXISTS get_kickstarter_item (
    i_kickstarter_item_id   BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_item (
    i_kickstarter_item_id   BIGINT
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
        v_sql := '
            SELECT 
                 ki.kickstarter_item_id     AS kickstater_item_id
                ,ki.item_name               AS item_name
                ,ki.description             AS description
                ,ki.is_physical_item        AS is_physical_item
                ,( SELECT COUNT(*)
                         FROM inventory.v_kickstarter_item ki WHERE true '||COALESCE(' AND ki.kickstarter_item_id='||i_kickstarter_item_id, '')||'
                       )::BIGINT   AS total
            FROM inventory.v_kickstarter_item ki
            WHERE TRUE'
            ||COALESCE(' AND i.kickstarter_item_id='||i_kickstarter_item_id, '')||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_item_id        := REC.kickstarter_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.description                := REC.description;
            v_return.is_physical_item           := REC.is_physical_item;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_kickstarter_item (
    i_kickstarter_item_id   BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter_item (
    i_kickstarter_item_id   BIGINT
)
RETURNS SETOF inventory.t_kickstarter_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_kickstarter_item;
    BEGIN
        IF i_kickstarter_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 ki.kickstarter_item_id     AS kickstater_item_id
                ,ki.item_name               AS item_name
                ,ki.description             AS description
                ,ki.is_physical_item        AS is_physical_item
                ,1                          AS total
            FROM inventory.v_kickstarter_item ki
            WHERE ki.kickstarter_item_id='||i_kickstarter_item_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_item_id        := REC.kickstarter_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.description                := REC.description;
            v_return.is_physical_item           := REC.is_physical_item;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

