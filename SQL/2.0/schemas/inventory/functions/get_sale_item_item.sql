DROP FUNCTION IF EXISTS get_sale_item_item (
    i_sale_item_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_item_item (
    i_sale_item_id      BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_item_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item_item;
    BEGIN
        IF i_sale_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sii.sale_item_item_id          AS sale_item_item_id
                ,sii.sale_item_id               AS sale_item_id
                ,sii.sale_name                  AS sale_name
                ,sii.sale_description           AS sale_description
                ,sii.sale_item_item_quantity    AS sale_item_item_quantity
                ,sii.price                      AS price
                ,sii.sale_insert_ts             AS sale_insert_ts
                ,sii.sale_active                AS sale_active
                ,sii.item_id                    AS item_id
                ,sii.code                       AS code
                ,sii.item_name                  AS item_name
                ,sii.item_description           AS item_description
                ,sii.weight_ounces              AS weight_ounces
                ,sii.item_type_id               AS item_type_id
                ,sii.item_type_name             AS item_type_name
                ,sii.quantity                   AS quantity            
                ,sii.item_active                AS item_active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_item_item sii
                         WHERE sii.sale_item_id='||i_sale_item_id||'
                       )::BIGINT        AS total
            FROM inventory.v_sale_item_item sii
            WHERE sii.sale_item_id='||i_sale_item_id||'
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_item_id          := REC.sale_item_item_id;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_name                  := REC.sale_name;
            v_return.sale_description           := REC.sale_description;
            v_return.sale_item_item_quantity    := REC.sale_item_item_quantity;
            v_return.price                      := REC.price;
            v_return.sale_insert_ts             := REC.sale_insert_ts;
            v_return.sale_active                := REC.sale_active;
            v_return.item_id                    := REC.item_id;
            v_return.code                       := REC.code;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.weight_ounces              := REC.weight_ounces;
            v_return.item_type_id               := REC.item_type_id;
            v_return.item_type_name             := REC.item_type_name;
            v_return.quantity                   := REC.quantity;
            v_return.item_active                := REC.item_active;
            v_return.total                      := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_item_item (
    i_sale_item_id              BIGINT
  , i_filter_sale_name          CHARACTER VARYING
  , i_filter_sale_description   TEXT
  , i_filter_item_code          CHARACTER VARYING
  , i_filter_item_name          CHARACTER VARYING
  , i_filter_item_description   TEXT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_item_item (
    i_sale_item_id              BIGINT
  , i_filter_sale_name          CHARACTER VARYING
  , i_filter_sale_description   TEXT
  , i_filter_item_code          CHARACTER VARYING
  , i_filter_item_name          CHARACTER VARYING
  , i_filter_item_description   TEXT
  , i_sort_field                BIGINT
  , i_offset                    BIGINT
  , i_limit                     BIGINT
)
RETURNS SETOF inventory.t_sale_item_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item_item;
    BEGIN
        IF i_sale_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sii.sale_item_item_id          AS sale_item_item_id
                ,sii.sale_item_id               AS sale_item_id
                ,sii.sale_name                  AS sale_name
                ,sii.sale_description           AS sale_description
                ,sii.sale_item_item_quantity    AS sale_item_item_quantity
                ,sii.price                      AS price
                ,sii.sale_insert_ts             AS sale_insert_ts
                ,sii.sale_active                AS sale_active
                ,sii.item_id                    AS item_id
                ,sii.code                       AS code
                ,sii.item_name                  AS item_name
                ,sii.item_description           AS item_description
                ,sii.weight_ounces              AS weight_ounces
                ,sii.item_type_id               AS item_type_id
                ,sii.item_type_name             AS item_type_name
                ,sii.quantity                   AS quantity            
                ,sii.item_active                AS item_active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_item_item sii
                         WHERE sii.sale_item_id='||i_sale_item_id
                         || COALESCE(' AND sale_name ILIKE ' || quote_literal(i_filter_sale_name||'%'),'')
                         || COALESCE(' AND sale_description ILIKE ' || quote_literal(i_filter_sale_description||'%'),'')
                         || COALESCE(' AND code ILIKE ' || quote_literal(i_filter_item_code||'%'),'')
                         || COALESCE(' AND item_name ILIKE ' || quote_literal(i_filter_item_name||'%'),'')
                         || COALESCE(' AND item_description ILIKE ' || quote_literal(i_filter_item_description||'%'),'')
                         ||
                       ')::BIGINT        AS total
            FROM inventory.v_sale_item_item sii
            WHERE sii.sale_item_id='||i_sale_item_id
            || COALESCE(' AND sale_name ILIKE ' || quote_literal(i_filter_sale_name||'%'),'')
            || COALESCE(' AND sale_description ILIKE ' || quote_literal(i_filter_sale_description||'%'),'')
            || COALESCE(' AND code ILIKE ' || quote_literal(i_filter_item_code||'%'),'')
            || COALESCE(' AND item_name ILIKE ' || quote_literal(i_filter_item_name||'%'),'')
            || COALESCE(' AND item_description ILIKE ' || quote_literal(i_filter_item_description||'%'),'')
            ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_item_id          := REC.sale_item_item_id;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_name                  := REC.sale_name;
            v_return.sale_description           := REC.sale_description;
            v_return.sale_item_item_quantity    := REC.sale_item_item_quantity;
            v_return.price                      := REC.price;
            v_return.sale_insert_ts             := REC.sale_insert_ts;
            v_return.sale_active                := REC.sale_active;
            v_return.item_id                    := REC.item_id;
            v_return.code                       := REC.code;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.weight_ounces              := REC.weight_ounces;
            v_return.item_type_id               := REC.item_type_id;
            v_return.item_type_name             := REC.item_type_name;
            v_return.quantity                   := REC.quantity;
            v_return.item_active                := REC.item_active;
            v_return.total                      := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_item_item (
    i_sale_item_item_id  BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_item_item (
    i_sale_item_item_id  BIGINT
)
RETURNS SETOF inventory.t_sale_item_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item_item;
    BEGIN
        IF i_sale_item_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sii.sale_item_item_id          AS sale_item_item_id
                ,sii.sale_item_id               AS sale_item_id
                ,sii.sale_name                  AS sale_name
                ,sii.sale_description           AS sale_description
                ,sii.sale_item_item_quantity    AS sale_item_item_quantity
                ,sii.price                      AS price
                ,sii.sale_insert_ts             AS sale_insert_ts
                ,sii.sale_active                AS sale_active
                ,sii.item_id                    AS item_id
                ,sii.code                       AS code
                ,sii.item_name                  AS item_name
                ,sii.item_description           AS item_description
                ,sii.weight_ounces              AS weight_ounces
                ,sii.item_type_id               AS item_type_id
                ,sii.item_type_name             AS item_type_name
                ,sii.quantity                   AS quantity            
                ,sii.item_active                AS item_active
                ,1                              AS total
            FROM inventory.v_sale_item_item sii
            WHERE sii.sale_item_item_id='||i_sale_item_item_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_item_id          := REC.sale_item_item_id;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_name                  := REC.sale_name;
            v_return.sale_description           := REC.sale_description;
            v_return.sale_item_item_quantity    := REC.sale_item_item_quantity;
            v_return.price                      := REC.price;
            v_return.sale_insert_ts             := REC.sale_insert_ts;
            v_return.sale_active                := REC.sale_active;
            v_return.item_id                    := REC.item_id;
            v_return.code                       := REC.code;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.weight_ounces              := REC.weight_ounces;
            v_return.item_type_id               := REC.item_type_id;
            v_return.item_type_name             := REC.item_type_name;
            v_return.quantity                   := REC.quantity;
            v_return.item_active                := REC.item_active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_item_item (
      i_sale_item_id  BIGINT
    , i_item_id       BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_item_item (
      i_sale_item_id  BIGINT
    , i_item_id       BIGINT
)
RETURNS SETOF inventory.t_sale_item_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_item_item;
    BEGIN
        IF i_sale_item_id IS NULL OR i_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sii.sale_item_item_id          AS sale_item_item_id
                ,sii.sale_item_id               AS sale_item_id
                ,sii.sale_name                  AS sale_name
                ,sii.sale_description           AS sale_description
                ,sii.sale_item_item_quantity    AS sale_item_item_quantity
                ,sii.price                      AS price
                ,sii.sale_insert_ts             AS sale_insert_ts
                ,sii.sale_active                AS sale_active
                ,sii.item_id                    AS item_id
                ,sii.code                       AS code
                ,sii.item_name                  AS item_name
                ,sii.item_description           AS item_description
                ,sii.weight_ounces              AS weight_ounces
                ,sii.item_type_id               AS item_type_id
                ,sii.item_type_name             AS item_type_name
                ,sii.quantity                   AS quantity            
                ,sii.item_active                AS item_active
                ,1                              AS total
            FROM inventory.v_sale_item_item sii
            WHERE sii.sale_item_id='||i_sale_item_id||'
            AND   sii.item_id='||i_item_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_item_item_id          := REC.sale_item_item_id;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.sale_name                  := REC.sale_name;
            v_return.sale_description           := REC.sale_description;
            v_return.sale_item_item_quantity    := REC.sale_item_item_quantity;
            v_return.price                      := REC.price;
            v_return.sale_insert_ts             := REC.sale_insert_ts;
            v_return.sale_active                := REC.sale_active;
            v_return.item_id                    := REC.item_id;
            v_return.code                       := REC.code;
            v_return.item_name                  := REC.item_name;
            v_return.item_description           := REC.item_description;
            v_return.weight_ounces              := REC.weight_ounces;
            v_return.item_type_id               := REC.item_type_id;
            v_return.item_type_name             := REC.item_type_name;
            v_return.quantity                   := REC.quantity;
            v_return.item_active                := REC.item_active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
