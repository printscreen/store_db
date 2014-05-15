DROP FUNCTION IF EXISTS get_user_digital_item (
    i_user_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_user_digital_item (
    i_user_id           BIGINT
)
RETURNS SETOF transaction.t_user_digital_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_user_digital_item;
    BEGIN
        IF i_user_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT DISTINCT
                 di.item_id                 AS item_id
                ,di.user_id                 AS user_id
                ,di.order_id                AS order_id
                ,di.order_number            AS order_number
                ,di.sale_item_id            AS sale_item_id
                ,di.name                    AS name
                ,di.active                  AS active
                ,di.description             AS description
                ,di.file_path               AS file_path
                ,di.file_path_orgin_id      AS file_path_orgin_id
                ,di.file_path_orgin_name    AS file_path_orgin_name
                ,( SELECT COUNT(*)
                         FROM transaction.v_user_digital_item di
                         WHERE user_id = ' || i_user_id || '
                       )::BIGINT       AS total
            FROM transaction.v_user_digital_item di WHERE user_id = ' || i_user_id || '  ORDER BY order_number ASC;';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id                    := REC.item_id;
            v_return.user_id                    := REC.user_id;
            v_return.order_id                   := REC.order_id;
            v_return.order_number               := REC.order_number;
            v_return.sale_item_id               := REC.sale_item_id;
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

DROP FUNCTION IF EXISTS get_user_digital_item (
    i_user_id           BIGINT
  , i_order_id          BIGINT
  , i_sale_item_id      BIGINT
  , i_item_id           BIGINT
);
CREATE OR REPLACE FUNCTION get_user_digital_item (
    i_user_id           BIGINT
  , i_order_id          BIGINT
  , i_sale_item_id      BIGINT
  , i_item_id           BIGINT
)
RETURNS SETOF transaction.t_user_digital_item
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_user_digital_item;
    BEGIN
        IF i_item_id IS NULL OR i_user_id IS NULL OR i_order_id IS NULL OR i_sale_item_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 di.item_id                 AS item_id
                ,di.user_id                 AS user_id
                ,di.order_id                AS order_id
                ,di.order_number            AS order_number
                ,di.sale_item_id            AS sale_item_id
                ,di.name                    AS name
                ,di.active                  AS active
                ,di.description             AS description
                ,di.file_path               AS file_path
                ,di.file_path_orgin_id      AS file_path_orgin_id
                ,di.file_path_orgin_name    AS file_path_orgin_name
                ,1                          AS total
            FROM transaction.v_user_digital_item di
            WHERE item_id = ' || i_item_id || 
            ' AND user_id = '|| i_user_id || 
            ' AND order_id = '|| i_order_id || 
            ' AND sale_item_id = '|| i_sale_item_id || ' ORDER BY order_number ASC;';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.item_id                    := REC.item_id;
            v_return.user_id                    := REC.user_id;
            v_return.order_id                   := REC.order_id;
            v_return.order_number               := REC.order_number;
            v_return.sale_item_id               := REC.sale_item_id;
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