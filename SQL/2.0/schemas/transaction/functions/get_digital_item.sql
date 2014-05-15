DROP FUNCTION IF EXISTS get_digital_item (
    i_file_path_orgin_id    BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
);
CREATE OR REPLACE FUNCTION get_digital_item (
    i_file_path_orgin_id    BIGINT
  , i_sort_field            BIGINT
  , i_offset                BIGINT
  , i_limit                 BIGINT
)
RETURNS SETOF transaction.t_digital_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_digital_item;
    BEGIN
	    
        v_sql := '
            SELECT 
                 di.item_id                 AS item_id
                ,di.name                    AS name
                ,di.active                  AS active
                ,di.description             AS description
                ,di.file_path               AS file_path
                ,di.file_path_orgin_id      AS file_path_orgin_id
                ,di.file_path_orgin_name    AS file_path_orgin_name
                ,( SELECT COUNT(*)
                         FROM inventory.v_digital_item d
                         WHERE true '|| COALESCE(' AND file_path_orgin_id = ' || i_file_path_orgin_id,'')||'
                            )::BIGINT       AS total
            FROM inventory.v_digital_item di
            WHERE true '|| COALESCE(' AND file_path_orgin_id = ' || i_file_path_orgin_id,'')||' 
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id                    := REC.item_id;
            v_return.name                       := REC.name;
            v_return.active                     := REC.active;
            v_return.description                := REC.description;
            v_return.file_path                  := REC.file_path;
            v_return.file_path_orgin_id         := REC.file_path_orgin_id;
            v_return.file_path_orgin_name       := REC.file_path_orgin_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_digital_item (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_digital_item (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_digital_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_digital_item;
    BEGIN
        
        v_sql := '
            SELECT 
                 di.item_id                 AS item_id
                ,di.name                    AS name
                ,di.active                  AS active
                ,di.description             AS description
                ,di.file_path               AS file_path
                ,di.file_path_orgin_id      AS file_path_orgin_id
                ,di.file_path_orgin_name    AS file_path_orgin_name
                ,( SELECT COUNT(*)
                         FROM inventory.v_digital_item d
                            )::BIGINT       AS total
            FROM inventory.v_digital_item di 
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id                    := REC.item_id;
            v_return.name                       := REC.name;
            v_return.active                     := REC.active;
            v_return.description                := REC.description;
            v_return.file_path                  := REC.file_path;
            v_return.file_path_orgin_id         := REC.file_path_orgin_id;
            v_return.file_path_orgin_name       := REC.file_path_orgin_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_digital_item (
    i_item_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_digital_item (
    i_item_id           BIGINT
)
RETURNS SETOF transaction.t_digital_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_digital_item;
    BEGIN
        IF i_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 di.item_id                 AS item_id
                ,di.name                    AS name
                ,di.active                  AS active
                ,di.description             AS description
                ,di.file_path               AS file_path
                ,di.file_path_orgin_id      AS file_path_orgin_id
                ,di.file_path_orgin_name    AS file_path_orgin_name
                ,1                          AS total
            FROM inventory.v_digital_item di WHERE item_id = ' || i_item_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id                    := REC.item_id;
            v_return.name                       := REC.name;
            v_return.active                     := REC.active;
            v_return.description                := REC.description;
            v_return.file_path                  := REC.file_path;
            v_return.file_path_orgin_id         := REC.file_path_orgin_id;
            v_return.file_path_orgin_name       := REC.file_path_orgin_name;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
