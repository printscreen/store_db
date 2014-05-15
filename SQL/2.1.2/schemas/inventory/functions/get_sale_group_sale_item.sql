DROP FUNCTION IF EXISTS get_sale_group_sale_item (
    i_sale_group_id     BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_sale_item (
    i_sale_group_id     BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_group_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_sale_item;
    BEGIN
        IF i_sale_group_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sgsi.sale_group_sale_item_id   AS sale_group_sale_item_id
                ,sgsi.sale_group_id             AS sale_group_id
                ,sgsi.group_name                AS group_name
                ,sgsi.group_description         AS group_description
                ,sgsi.group_insert_ts           AS group_insert_ts
                ,sgsi.group_active              AS group_active
                ,sgsi.sale_item_id              AS sale_item_id
                ,sgsi.item_name                 AS item_name
                ,sgsi.item_description          AS item_description
                ,sgsi.price                     AS price
                ,sgsi.item_insert_ts            AS item_insert_ts
                ,sgsi.item_active               AS item_active
                ,sgsi.in_stock                  AS in_stock
                ,sgsi.number_available          AS number_available
                ,sgsi.order_number              AS order_number
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_group_sale_item sgsi
                         WHERE sgsi.sale_group_id='||i_sale_group_id||'
                       )::BIGINT                AS total
            FROM inventory.v_sale_group_sale_item sgsi
            WHERE sgsi.sale_group_id='||i_sale_group_id||'
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_sale_item_id    := REC.sale_group_sale_item_id;
            v_return.sale_group_id              := REC.sale_group_id;
            v_return.group_name                 := REC.group_name;
            v_return.group_description          := REC.group_description;
            v_return.group_insert_ts            := REC.group_insert_ts;
            v_return.group_active               := REC.group_active;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.price                      := REC.price;
            v_return.item_insert_ts             := REC.item_insert_ts;
            v_return.item_active                := REC.item_active;
            v_return.in_stock                   := REC.in_stock;
            v_return.number_available           := REC.number_available;
            v_return.order_number               := REC.order_number;
            v_return.total                      := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group_sale_item (
    i_sale_group_id             BIGINT
  , i_filter_group_name         CHARACTER VARYING
  , i_filter_group_description  TEXT
  , i_filter_item_name          CHARACTER VARYING
  , i_filter_item_description   TEXT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_sale_item (
    i_sale_group_id             BIGINT
  , i_filter_group_name         CHARACTER VARYING
  , i_filter_group_description  TEXT
  , i_filter_item_name          CHARACTER VARYING
  , i_filter_item_description   TEXT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
)
RETURNS SETOF inventory.t_sale_group_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_sale_item;
    BEGIN
        IF i_sale_group_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sgsi.sale_group_sale_item_id   AS sale_group_sale_item_id
                ,sgsi.sale_group_id             AS sale_group_id
                ,sgsi.group_name                AS group_name
                ,sgsi.group_description         AS group_description
                ,sgsi.group_insert_ts           AS group_insert_ts
                ,sgsi.group_active              AS group_active
                ,sgsi.sale_item_id              AS sale_item_id
                ,sgsi.item_name                 AS item_name
                ,sgsi.item_description          AS item_description
                ,sgsi.price                     AS price
                ,sgsi.item_insert_ts            AS item_insert_ts
                ,sgsi.item_active               AS item_active
                ,sgsi.in_stock                  AS in_stock
                ,sgsi.number_available          AS number_available
                ,sgsi.order_number              AS order_number
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_group_sale_item sgsi
                         WHERE sgsi.sale_group_id='||i_sale_group_id 
                         || COALESCE(' AND group_name ILIKE ' || quote_literal(i_filter_group_name||'%'),'')
                         || COALESCE(' AND group_description ILIKE ' || quote_literal(i_filter_group_description||'%'),'')
                         || COALESCE(' AND item_name ILIKE ' || quote_literal(i_filter_item_name||'%'),'')
                         || COALESCE(' AND item_description ILIKE ' || quote_literal(i_filter_item_description||'%'),'')
                         ||
                      ' )::BIGINT                AS total
            FROM inventory.v_sale_group_sale_item sgsi
            WHERE sgsi.sale_group_id='||i_sale_group_id
            || COALESCE(' AND group_name ILIKE ' || quote_literal(i_filter_group_name||'%'),'')
            || COALESCE(' AND group_description ILIKE ' || quote_literal(i_filter_group_description||'%'),'')
            || COALESCE(' AND item_name ILIKE ' || quote_literal(i_filter_item_name||'%'),'')
            || COALESCE(' AND item_description ILIKE ' || quote_literal(i_filter_item_description||'%'),'')
            ||'
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_sale_item_id    := REC.sale_group_sale_item_id;
            v_return.sale_group_id              := REC.sale_group_id;
            v_return.group_name                 := REC.group_name;
            v_return.group_description          := REC.group_description;
            v_return.group_insert_ts            := REC.group_insert_ts;
            v_return.group_active               := REC.group_active;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.price                      := REC.price;
            v_return.item_insert_ts             := REC.item_insert_ts;
            v_return.item_active                := REC.item_active;
            v_return.in_stock                   := REC.in_stock;
            v_return.number_available           := REC.number_available;
            v_return.order_number               := REC.order_number;
            v_return.total                      := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group_sale_item (
    i_sale_group_sale_item_id  BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_sale_item (
    i_sale_group_sale_item_id  BIGINT
)
RETURNS SETOF inventory.t_sale_group_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_sale_item;
    BEGIN
        IF i_sale_group_sale_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sgsi.sale_group_sale_item_id   AS sale_group_sale_item_id
                ,sgsi.sale_group_id             AS sale_group_id
                ,sgsi.group_name                AS group_name
                ,sgsi.group_description         AS group_description
                ,sgsi.group_insert_ts           AS group_insert_ts
                ,sgsi.group_active              AS group_active
                ,sgsi.sale_item_id              AS sale_item_id
                ,sgsi.item_name                 AS item_name
                ,sgsi.item_description          AS item_description
                ,sgsi.price                     AS price
                ,sgsi.item_insert_ts            AS item_insert_ts
                ,sgsi.item_active               AS item_active
                ,sgsi.in_stock                  AS in_stock
                ,sgsi.number_available          AS number_available
                ,sgsi.order_number              AS order_number
                ,1                              AS total
            FROM inventory.v_sale_group_sale_item sgsi
            WHERE sgsi.sale_group_sale_item_id='||i_sale_group_sale_item_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_sale_item_id    := REC.sale_group_sale_item_id;
            v_return.sale_group_id              := REC.sale_group_id;
            v_return.group_name                 := REC.group_name;
            v_return.group_description          := REC.group_description;
            v_return.group_insert_ts            := REC.group_insert_ts;
            v_return.group_active               := REC.group_active;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.price                      := REC.price;
            v_return.item_insert_ts             := REC.item_insert_ts;
            v_return.item_active                := REC.item_active;
            v_return.in_stock                   := REC.in_stock;
            v_return.number_available           := REC.number_available;
            v_return.order_number               := REC.order_number;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group_sale_item (
    i_sale_group_id BIGINT
  , i_sale_item_id  BIGINT 
);
CREATE OR REPLACE FUNCTION get_sale_group_sale_item (
    i_sale_group_id BIGINT
  , i_sale_item_id  BIGINT
)
RETURNS SETOF inventory.t_sale_group_sale_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_sale_item;
    BEGIN
        IF i_sale_group_id IS NULL OR i_sale_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sgsi.sale_group_sale_item_id   AS sale_group_sale_item_id
                ,sgsi.sale_group_id             AS sale_group_id
                ,sgsi.group_name                AS group_name
                ,sgsi.group_description         AS group_description
                ,sgsi.group_insert_ts           AS group_insert_ts
                ,sgsi.group_active              AS group_active
                ,sgsi.sale_item_id              AS sale_item_id
                ,sgsi.item_name                 AS item_name
                ,sgsi.item_description          AS item_description
                ,sgsi.price                     AS price
                ,sgsi.item_insert_ts            AS item_insert_ts
                ,sgsi.item_active               AS item_active
                ,sgsi.in_stock                  AS in_stock
                ,sgsi.number_available          AS number_available
                ,sgsi.order_number              AS order_number
                ,1                              AS total
            FROM inventory.v_sale_group_sale_item sgsi
            WHERE sgsi.sale_group_id='|| i_sale_group_id ||'
            AND sgsi.sale_item_id = '|| i_sale_item_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_sale_item_id    := REC.sale_group_sale_item_id;
            v_return.sale_group_id              := REC.sale_group_id;
            v_return.group_name                 := REC.group_name;
            v_return.group_description          := REC.group_description;
            v_return.group_insert_ts            := REC.group_insert_ts;
            v_return.group_active               := REC.group_active;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.price                      := REC.price;
            v_return.item_insert_ts             := REC.item_insert_ts;
            v_return.item_active                := REC.item_active;
            v_return.in_stock                   := REC.in_stock;
            v_return.number_available           := REC.number_available;
            v_return.order_number               := REC.order_number;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
