DROP FUNCTION IF EXISTS get_item_by_attribute_id (
    i_attribute_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_item_by_attribute_id (
    i_attribute_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_item_attribute
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item_attribute;
    BEGIN

        v_sql := '
            SELECT 
                 ia.item_attribute_id   AS item_attribute_id
                ,ia.item_id             AS item_id
                ,ia.item_code           AS item_code
                ,ia.item_name           AS item_name
                ,ia.description         AS description
                ,ia.weight_ounces       AS weight_ounces
                ,ia.quantity            AS quantity
                ,ia.active              AS active
                ,ia.attribute_id        AS attribute_id
                ,ia.attribute_name      AS attribute_name
                ,ia.attribute_parent_id AS attribute_parent_id
                ,( SELECT COUNT(*)
                         FROM inventory.v_item_attribute ia WHERE TRUE '
                ||COALESCE(' AND ia.attribute_id='||i_attribute_id, ' AND ia.attribute_id IS NULL')||'
                       )::BIGINT   AS total
            FROM inventory.v_item_attribute ia
            WHERE TRUE'
            ||COALESCE(' AND ia.attribute_id='||i_attribute_id, ' AND ia.attribute_id IS NULL')|| 
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_attribute_id      := REC.item_attribute_id;
            v_return.item_id                := REC.item_id;
            v_return.item_code              := REC.item_code;
            v_return.item_name              := REC.item_name;
            v_return.description            := REC.description;
            v_return.weight_ounces          := REC.weight_ounces;
            v_return.quantity               := REC.quantity;
            v_return.active                 := REC.active;
            v_return.attribute_id           := REC.attribute_id;
            v_return.attribute_name         := REC.attribute_name;
            v_return.attribute_parent_id    := REC.attribute_parent_id;
            v_return.total                  := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
