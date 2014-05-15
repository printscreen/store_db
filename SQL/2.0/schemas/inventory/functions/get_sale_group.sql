DROP FUNCTION IF EXISTS get_sale_group (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group;
    BEGIN
        v_sql := '
            SELECT 
                 sg.sale_group_id   AS sale_group_id
                ,sg.name            AS name
                ,sg.description     AS description
                ,sg.url             AS url
                ,sg.thumbnail       AS thumbnail
                ,sg.insert_ts       AS insert_ts
                ,sg.active          AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_group sg
                       )::BIGINT    AS total
            FROM inventory.v_sale_group sg
            WHERE TRUE
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_id      := REC.sale_group_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.url                := REC.url;
            v_return.thumbnail          := REC.thumbnail;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group (
    i_filter_name           CHARACTER VARYING
  , i_filter_description    TEXT
  , i_filter_url            CHARACTER VARYING
  , i_filter_thumbnail      CHARACTER VARYING
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group (
    i_filter_name           CHARACTER VARYING
  , i_filter_description    TEXT
  , i_filter_url            CHARACTER VARYING
  , i_filter_thumbnail      CHARACTER VARYING
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF inventory.t_sale_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group;
    BEGIN
        v_sql := '
            SELECT 
                 sg.sale_group_id   AS sale_group_id
                ,sg.name            AS name
                ,sg.description     AS description
                ,sg.url             AS url
                ,sg.thumbnail       AS thumbnail
                ,sg.insert_ts       AS insert_ts
                ,sg.active          AS active
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_group sg
                         WHERE true '
                         || COALESCE(' AND name ILIKE ' || quote_literal(i_filter_name||'%'),'')
                         || COALESCE(' AND description ILIKE ' || quote_literal(i_filter_description||'%'),'')
                         || COALESCE(' AND url ILIKE ' || quote_literal(i_filter_url||'%'),'')
                         || COALESCE(' AND thumbnail ILIKE ' || quote_literal(i_filter_thumbnail||'%'),'')
                         ||
                       ')::BIGINT    AS total
            FROM inventory.v_sale_group sg
            WHERE TRUE '
            || COALESCE(' AND name ILIKE ' || quote_literal(i_filter_name||'%'),'')
            || COALESCE(' AND description ILIKE ' || quote_literal(i_filter_description||'%'),'')
            || COALESCE(' AND url ILIKE ' || quote_literal(i_filter_url||'%'),'')
            || COALESCE(' AND thumbnail ILIKE ' || quote_literal(i_filter_thumbnail||'%'),'')
            ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_id      := REC.sale_group_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.url                := REC.url;
            v_return.thumbnail          := REC.thumbnail;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group (
    i_sale_group_id BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group (
    i_sale_group_id BIGINT
)
RETURNS SETOF inventory.t_sale_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group;
    BEGIN
        IF i_sale_group_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sg.sale_group_id   AS sale_group_id
                ,sg.name            AS name
                ,sg.description     AS description
                ,sg.url             AS url
                ,sg.thumbnail       AS thumbnail
                ,sg.insert_ts       AS insert_ts
                ,sg.active          AS active
                ,1                  AS total
            FROM inventory.v_sale_group sg
            WHERE sg.sale_group_id='||i_sale_group_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_id      := REC.sale_group_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.url                := REC.url;
            v_return.thumbnail          := REC.thumbnail;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group (
    i_url CHARACTER VARYING
);
CREATE OR REPLACE FUNCTION get_sale_group (
    i_url CHARACTER VARYING
)
RETURNS SETOF inventory.t_sale_group
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group;
    BEGIN
        IF i_url IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sg.sale_group_id   AS sale_group_id
                ,sg.name            AS name
                ,sg.description     AS description
                ,sg.url             AS url
                ,sg.thumbnail       AS thumbnail
                ,sg.insert_ts       AS insert_ts
                ,sg.active          AS active
                ,1                  AS total
            FROM inventory.v_sale_group sg
            WHERE sg.url='||quote_literal(i_url)||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_id      := REC.sale_group_id;
            v_return.name               := REC.name;
            v_return.description        := REC.description;
            v_return.url                := REC.url;
            v_return.thumbnail          := REC.thumbnail;
            v_return.insert_ts          := REC.insert_ts;
            v_return.active             := REC.active;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
