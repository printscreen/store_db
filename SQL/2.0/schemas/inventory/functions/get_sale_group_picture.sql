DROP FUNCTION IF EXISTS get_sale_group_picture (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_picture (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_group_picture
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_picture;
    BEGIN
        v_sql := '
            SELECT 
                 sgp.sale_group_picture_id  AS sale_group_picture_id
                ,sgp.sale_group_id          AS sale_group_id
                ,sgp.file_path              AS file_path
                ,sgp.thumbnail_path         AS thumbnail_path
                ,sgp.alt_text               AS alt_text
                ,sgp.primary_picture        AS primary_picture
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_group_picture sgp
                       )::BIGINT            AS total
            FROM inventory.v_sale_group_picture sgp
            WHERE TRUE
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_picture_id  := REC.sale_group_picture_id;
            v_return.sale_group_id          := REC.sale_group_id;
            v_return.file_path              := REC.file_path;
            v_return.thumbnail_path         := REC.thumbnail_path;
            v_return.alt_text               := REC.alt_text;
            v_return.primary_picture        := REC.primary_picture;
            v_return.total                  := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group_picture (
    i_sale_group_id     BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_picture (
    i_sale_group_id     BIGINT
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF inventory.t_sale_group_picture
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_picture;
    BEGIN
	    IF i_sale_group_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 sgp.sale_group_picture_id  AS sale_group_picture_id
                ,sgp.sale_group_id          AS sale_group_id
                ,sgp.file_path              AS file_path
                ,sgp.thumbnail_path         AS thumbnail_path
                ,sgp.alt_text               AS alt_text
                ,sgp.primary_picture        AS primary_picture
                ,( SELECT COUNT(*)
                         FROM inventory.v_sale_group_picture sgp
                         WHERE sgp.sale_group_id = ' || i_sale_group_id || '
                       )::BIGINT            AS total
            FROM inventory.v_sale_group_picture sgp
            WHERE sgp.sale_group_id = ' || i_sale_group_id || '
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_picture_id  := REC.sale_group_picture_id;
            v_return.sale_group_id          := REC.sale_group_id;
            v_return.file_path              := REC.file_path;
            v_return.thumbnail_path         := REC.thumbnail_path;
            v_return.alt_text               := REC.alt_text;
            v_return.primary_picture        := REC.primary_picture;
            v_return.total                  := REC.total;

            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_group_picture (
    i_sale_group_picture_id BIGINT
);
CREATE OR REPLACE FUNCTION get_sale_group_picture (
    i_sale_group_picture_id BIGINT
)
RETURNS SETOF inventory.t_sale_group_picture
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return inventory.t_sale_group_picture;
    BEGIN
        IF i_sale_group_picture_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 sgp.sale_group_picture_id  AS sale_group_picture_id
                ,sgp.sale_group_id          AS sale_group_id
                ,sgp.file_path              AS file_path
                ,sgp.thumbnail_path         AS thumbnail_path
                ,sgp.alt_text               AS alt_text
                ,sgp.primary_picture        AS primary_picture
                ,1                          AS total
            FROM inventory.v_sale_group_picture sgp
            WHERE sgp.sale_group_picture_id='||i_sale_group_picture_id||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_group_picture_id  := REC.sale_group_picture_id;
            v_return.sale_group_id          := REC.sale_group_id;
            v_return.file_path              := REC.file_path;
            v_return.thumbnail_path         := REC.thumbnail_path;
            v_return.alt_text               := REC.alt_text;
            v_return.primary_picture        := REC.primary_picture;
            v_return.total                  := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
