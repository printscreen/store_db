DROP FUNCTION IF EXISTS get_item (
    i_item_id           BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
DROP FUNCTION IF EXISTS get_item (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_item (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item;
    BEGIN
        v_sql := '
            SELECT 
                 i.item_id          AS item_id
                ,i.item_code        AS item_code
                ,i.item_name        AS item_name
                ,i.item_type_id     AS item_type_id
                ,i.item_type_name   AS item_type_name
                ,i.description      AS description
                ,i.quantity         AS quantity
                ,i.weight_ounces    AS weight_ounces
                ,i.active           AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_item i
                       )::BIGINT   AS total
            FROM inventory.v_item i
            WHERE TRUE
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id            := REC.item_id;
            v_return.item_code          := REC.item_code;
            v_return.item_name          := REC.item_name;
            v_return.item_type_id       := REC.item_type_id;
            v_return.item_type_name     := REC.item_type_name;
            v_return.description        := REC.description;
            v_return.quantity           := REC.quantity;
            v_return.weight_ounces      := REC.weight_ounces;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_item (
    i_item_type_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_item (
    i_item_type_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item;
    BEGIN
	    IF i_item_type_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 i.item_id          AS item_id
                ,i.item_code        AS item_code
                ,i.item_name        AS item_name
                ,i.item_type_id     AS item_type_id
                ,i.item_type_name   AS item_type_name
                ,i.description      AS description
                ,i.quantity         AS quantity
                ,i.weight_ounces    AS weight_ounces
                ,i.active           AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_item i
                         WHERE i.item_type_id = ' || i_item_type_id || '
                       )::BIGINT   AS total
            FROM inventory.v_item i
            WHERE i.item_type_id = ' || i_item_type_id || '
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id            := REC.item_id;
            v_return.item_code          := REC.item_code;
            v_return.item_name          := REC.item_name;
            v_return.item_type_id       := REC.item_type_id;
            v_return.item_type_name     := REC.item_type_name;
            v_return.description        := REC.description;
            v_return.quantity           := REC.quantity;
            v_return.weight_ounces      := REC.weight_ounces;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_item (
    i_filter_code           VARCHAR(128)
  , i_filter_name           VARCHAR(128)
  , i_filter_description    TEXT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_item (
    i_filter_code           VARCHAR(128)
  , i_filter_name           VARCHAR(128)
  , i_filter_description    TEXT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF inventory.t_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item;
    BEGIN
        v_sql := '
            SELECT 
                 i.item_id          AS item_id
                ,i.item_code        AS item_code
                ,i.item_name        AS item_name
                ,i.item_type_id     AS item_type_id
                ,i.item_type_name   AS item_type_name
                ,i.description      AS description
                ,i.quantity         AS quantity
                ,i.weight_ounces    AS weight_ounces
                ,i.active           AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_item i
                         WHERE true'
                         || COALESCE(' AND item_code ILIKE ' || quote_literal(i_filter_code||'%'),'')
                         || COALESCE(' AND item_name ILIKE ' || quote_literal(i_filter_name||'%'),'')
                         || COALESCE(' AND description ILIKE ' || quote_literal(i_filter_description||'%'),'')
                         ||
                       ')::BIGINT   AS total
            FROM inventory.v_item i
            WHERE TRUE'
                         || COALESCE(' AND item_code ILIKE ' || quote_literal(i_filter_code||'%'),'')
                         || COALESCE(' AND item_name ILIKE ' || quote_literal(i_filter_name||'%'),'')
                         || COALESCE(' AND description ILIKE ' || quote_literal(i_filter_description||'%'),'')
                         ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id            := REC.item_id;
            v_return.item_code          := REC.item_code;
            v_return.item_name          := REC.item_name;
            v_return.item_type_id       := REC.item_type_id;
            v_return.item_type_name     := REC.item_type_name;
            v_return.description        := REC.description;
            v_return.quantity           := REC.quantity;
            v_return.weight_ounces      := REC.weight_ounces;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_item (
    i_item_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_item (
    i_item_id           BIGINT
)
RETURNS SETOF inventory.t_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_item;
    BEGIN
        IF i_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 i.item_id          AS item_id
                ,i.item_code        AS item_code
                ,i.item_name        AS item_name
                ,i.item_type_id     AS item_type_id
                ,i.item_type_name   AS item_type_name
                ,i.description      AS description
                ,i.quantity         AS quantity
                ,i.weight_ounces    AS weight_ounces
                ,i.active           AS active
                ,1                  AS total
            FROM inventory.v_item i
            WHERE i.item_id='||i_item_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id            := REC.item_id;
            v_return.item_code          := REC.item_code;
            v_return.item_name          := REC.item_name;
            v_return.item_type_id       := REC.item_type_id;
            v_return.item_type_name     := REC.item_type_name;
            v_return.description        := REC.description;
            v_return.quantity           := REC.quantity;
            v_return.weight_ounces      := REC.weight_ounces;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
