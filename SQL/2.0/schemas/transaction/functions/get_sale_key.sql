DROP FUNCTION IF EXISTS get_sale_key (
    i_order_id      BIGINT
  , i_user_id       BIGINT
  , i_sale_item_id  BIGINT
  , i_item_id       BIGINT
);

CREATE OR REPLACE FUNCTION get_sale_key (
    i_order_id      BIGINT
  , i_user_id       BIGINT
  , i_sale_item_id  BIGINT
  , i_item_id       BIGINT
)
RETURNS SETOF transaction.t_sale_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_sale_key;
    BEGIN
	    IF i_order_id IS NULL OR
	       i_user_id IS NULL OR
	       i_sale_item_id IS NULL OR
	       i_item_id IS NULL
	    THEN
	       RETURN;
	    END IF;
	    /* Require User id, this is for validation. Since user id is pulled from session 
	     * is makes it impossible to pass your own post vars and get someone else's key */
	    
        v_sql := '
            SELECT 
                 sk.sale_key_id         AS sale_key_id
                ,sk.key                 AS key
                ,sk.order_id            AS order_id
                ,sk.user_id             AS user_id
                ,sk.sale_item_id        AS sale_item_id
                ,sk.item_id             AS item_id
                ,1                      AS total
            FROM transaction.v_sale_key sk
            WHERE sk.order_id='|| i_order_id || ' AND ' ||
            'sk.user_id='|| i_user_id || ' AND ' ||
            'sk.sale_item_id='|| i_sale_item_id || ' AND ' ||
            'sk.item_id='|| i_item_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_key_id                := REC.sale_key_id;
            v_return.key                        := REC.key;
            v_return.order_id                   := REC.order_id;
            v_return.user_id                    := REC.user_id;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.item_id                    := REC.item_id;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_sale_key (
    i_sale_key_id          BIGINT
);

CREATE OR REPLACE FUNCTION get_sale_key (
    i_sale_key_id          BIGINT
)
RETURNS SETOF transaction.t_sale_key
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_sale_key;
    BEGIN
	    IF i_sale_key_id IS NULL THEN
	       RETURN;
	    END IF;
	    
        v_sql := '
            SELECT 
                 sk.sale_key_id         AS sale_key_id
                ,sk.key                 AS key
                ,sk.order_id            AS order_id
                ,sk.user_id             AS user_id
                ,sk.sale_item_id        AS sale_item_id
                ,sk.item_id             AS item_id
                ,1                      AS total
            FROM transaction.v_sale_key sk
            WHERE sk.sale_key_id='||i_sale_key_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.sale_key_id                := REC.sale_key_id;
            v_return.key                        := REC.key;
            v_return.order_id                   := REC.order_id;
            v_return.user_id                    := REC.user_id;
            v_return.sale_item_id               := REC.sale_item_id;
            v_return.item_id                    := REC.item_id;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

