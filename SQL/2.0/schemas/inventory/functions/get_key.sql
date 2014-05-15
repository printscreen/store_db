DROP FUNCTION IF EXISTS get_key (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_key (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_key;
    BEGIN
        v_sql := '
            SELECT 
                 k.key_id           AS key_id
                ,k.key              AS key
                ,k.item_id          AS item_id
                ,k.item_name        AS item_name
                ,k.user_id          AS user_id
                ,k.user_name        AS user_name
                ,k.insert_ts        AS insert_ts
                ,( SELECT COUNT(*)
                         FROM inventory.v_key k
                       )::BIGINT   AS total
            FROM inventory.v_key k
            WHERE TRUE
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.key_id             := REC.key_id;
            v_return.key                := REC.key;
            v_return.item_id            := REC.item_id;
            v_return.item_name          := REC.item_name;
            v_return.user_id            := REC.user_id;
            v_return.user_name          := REC.user_name;
            v_return.insert_ts          := REC.insert_ts;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_key (
    i_item_id           BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_key (
    i_item_id           BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_key;
    BEGIN
        IF i_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 k.key_id           AS key_id
                ,k.key              AS key
                ,k.item_id          AS item_id
                ,k.item_name        AS item_name
                ,k.user_id          AS user_id
                ,k.user_name        AS user_name
                ,k.insert_ts        AS insert_ts
                ,( SELECT COUNT(*)
                         FROM inventory.v_key k
                         WHERE k.item_id = ' || i_item_id || '
                       )::BIGINT   AS total
            FROM inventory.v_key k
            WHERE k.item_id = ' || i_item_id || '
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.key_id             := REC.key_id;
            v_return.key                := REC.key;
            v_return.item_id            := REC.item_id;
            v_return.item_name          := REC.item_name;
            v_return.user_id            := REC.user_id;
            v_return.user_name          := REC.user_name;
            v_return.insert_ts          := REC.insert_ts;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_key (
    i_key_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_key (
    i_key_id           BIGINT
)
RETURNS SETOF inventory.t_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_key;
    BEGIN
        IF i_key_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 k.key_id           AS key_id
                ,k.key              AS key
                ,k.item_id          AS item_id
                ,k.item_name        AS item_name
                ,k.user_id          AS user_id
                ,k.user_name        AS user_name
                ,k.insert_ts        AS insert_ts
                ,1                  AS total
            FROM inventory.v_key k
            WHERE k.key_id='||i_key_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.key_id             := REC.key_id;
            v_return.key                := REC.key;
            v_return.item_id            := REC.item_id;
            v_return.item_name          := REC.item_name;
            v_return.user_id            := REC.user_id;
            v_return.user_name          := REC.user_name;
            v_return.insert_ts          := REC.insert_ts;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_key (
    i_key           BIGINT
);
CREATE OR REPLACE FUNCTION get_key (
    i_key           BIGINT
)
RETURNS SETOF inventory.t_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_key;
    BEGIN
        IF i_key IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 k.key_id           AS key_id
                ,k.key              AS key
                ,k.item_id          AS item_id
                ,k.item_name        AS item_name
                ,k.user_id          AS user_id
                ,k.user_name        AS user_name
                ,k.insert_ts        AS insert_ts
                ,1                  AS total
            FROM inventory.v_key k
            WHERE k.key='||quote_literal(i_key)||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.key_id             := REC.key_id;
            v_return.key                := REC.key;
            v_return.item_id            := REC.item_id;
            v_return.item_name          := REC.item_name;
            v_return.user_id            := REC.user_id;
            v_return.user_name          := REC.user_name;
            v_return.insert_ts          := REC.insert_ts;
            v_return.total              := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;