DROP FUNCTION IF EXISTS get_sale_group_available_sale_item (
    i_sale_group_id     BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_available_sale_item (
    i_sale_group_id     BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item;
    BEGIN
	    IF i_sale_group_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 si.sale_item_id    AS sale_item_id
                ,si.name            AS name
                ,si.description     AS description
                ,si.price           AS price
                ,si.insert_ts       AS insert_ts
                ,si.active          AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_item si
                         WHERE sale_item_id NOT IN (
                             SELECT sale_item_id
                             FROM inventory.sale_group_sale_item
                             WHERE sale_group_id = '|| i_sale_group_id ||'
                         )
                       )::BIGINT   AS total
            FROM inventory.v_sale_item si
            WHERE sale_item_id NOT IN (
                SELECT sale_item_id
                FROM inventory.sale_group_sale_item
                WHERE sale_group_id = '|| i_sale_group_id ||'
            )
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';
    
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_id       := REC.sale_item_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.price              := REC.price;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
      
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group_available_sale_item (
    i_sale_group_id         BIGINT
  , i_filter_name           VARCHAR(128)
  , i_filter_description    TEXT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_available_sale_item (
    i_sale_group_id         BIGINT
  , i_filter_name           VARCHAR(128)
  , i_filter_description    TEXT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF inventory.t_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item;
    BEGIN
	    IF i_sale_group_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 si.sale_item_id    AS sale_item_id
                ,si.name            AS name
                ,si.description     AS description
                ,si.price           AS price
                ,si.insert_ts       AS insert_ts
                ,si.active          AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_item si
                         WHERE sale_item_id NOT IN (
                             SELECT sale_item_id
                             FROM inventory.sale_group_sale_item
                             WHERE sale_group_id = '|| i_sale_group_id ||'
                         )'
                         || COALESCE(' AND name ILIKE ' || quote_literal(i_filter_name||'%'),'')
                         || COALESCE(' AND description ILIKE ' || quote_literal(i_filter_description||'%'),'') ||
                       ')::BIGINT   AS total
            FROM inventory.v_sale_item si
            WHERE sale_item_id NOT IN (
                SELECT sale_item_id
                FROM inventory.sale_group_sale_item
                WHERE sale_group_id = '|| i_sale_group_id ||'
            )'
            || COALESCE(' AND name ILIKE ' || quote_literal(i_filter_name||'%'),'')
            || COALESCE(' AND description ILIKE ' || quote_literal(i_filter_description||'%'),'') ||         
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';
    
        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_id       := REC.sale_item_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.price              := REC.price;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
      
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;