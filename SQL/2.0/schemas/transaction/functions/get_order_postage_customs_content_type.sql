DROP FUNCTION IF EXISTS get_order_postage_customs_content_type (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_order_postage_customs_content_type (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_order_postage_customs_content_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_postage_customs_content_type;
    BEGIN
        v_sql := '
            SELECT 
                 ct.order_postage_customs_content_type_id   AS order_postage_customs_content_type_id
                ,ct.name                                    AS name
                ,( SELECT COUNT(*)
                         FROM transaction.v_order_postage_customs_content_type ct
                       )::BIGINT                            AS total
            FROM transaction.v_order_postage_customs_content_type ct
            ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_postage_customs_content_type_id  := REC.order_postage_customs_content_type_id;
            v_return.name                                   := REC.name;
            v_return.total                                  := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_order_postage_customs_content_type (
    i_order_postage_customs_content_type_id BIGINT
);
CREATE OR REPLACE FUNCTION get_order_postage_customs_content_type (
    i_order_postage_customs_content_type_id BIGINT
)
RETURNS SETOF transaction.t_order_postage_customs_content_type
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_order_postage_customs_content_type;
    BEGIN
        IF i_order_postage_customs_content_type_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 ct.order_postage_customs_content_type_id   AS order_postage_customs_content_type_id
                ,ct.name                                    AS name
                ,( SELECT COUNT(*)
                         FROM transaction.v_order_postage_customs_content_type ct
                       )::BIGINT                            AS total
            FROM transaction.v_order_postage_customs_content_type ct
            WHERE ct.order_postage_customs_content_type_id='||i_order_postage_customs_content_type_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.order_postage_customs_content_type_id  := REC.order_postage_customs_content_type_id;
            v_return.name                                   := REC.name;
            v_return.total                                  := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
