DROP FUNCTION IF EXISTS get_address (
    i_user_id           BIGINT
  , i_active            BOOLEAN
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_address (
    i_user_id           BIGINT
  , i_active            BOOLEAN
  , i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF transaction.t_address
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_address;
    BEGIN
        IF i_user_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 a.address_id           AS address_id
                ,a.insert_ts            AS insert_ts
                ,a.update_ts            AS update_ts
                ,a.street               AS street
                ,a.unit_number          AS unit_number
                ,a.city                 AS city
                ,a.state                AS state
                ,a.postal_code          AS postal_code
                ,a.country_id           AS country_id
                ,a.country_name         AS country_name
                ,a.country_code         AS country_code
                ,a.phone_number         AS phone_number
                ,a.user_id              AS user_id
                ,a.first_name           AS first_name
                ,a.last_name            AS last_name
                ,a.active               AS active
                ,( SELECT COUNT(*)
                         FROM transaction.v_address a WHERE true '
                        ||COALESCE(' AND a.user_id='||i_user_id, '')||
                        COALESCE(' AND a.active ='||i_active, '') ||'
                       )::BIGINT       AS total
            FROM transaction.v_address a
            WHERE TRUE'
            || COALESCE(' AND a.user_id='||i_user_id, '') ||
            COALESCE(' AND a.active ='||i_active, '') ||
            ' ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.address_id                 := REC.address_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.street                     := REC.street;
            v_return.unit_number                := REC.unit_number;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.postal_code                := REC.postal_code;
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.phone_number               := REC.phone_number;
            v_return.user_id                    := REC.user_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;



DROP FUNCTION IF EXISTS get_address (
    i_address_id        BIGINT
);
CREATE OR REPLACE FUNCTION get_address (
    i_address_id        BIGINT
)
RETURNS SETOF transaction.t_address
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return transaction.t_address;
    BEGIN
        IF i_address_id IS NULL THEN
           RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 a.address_id           AS address_id
                ,a.insert_ts            AS insert_ts
                ,a.update_ts            AS update_ts
                ,a.street               AS street
                ,a.unit_number          AS unit_number
                ,a.city                 AS city
                ,a.state                AS state
                ,a.postal_code          AS postal_code
                ,a.country_id           AS country_id
                ,a.country_name         AS country_name
                ,a.country_code         AS country_code
                ,a.phone_number         AS phone_number
                ,a.user_id              AS user_id
                ,a.first_name           AS first_name
                ,a.last_name            AS last_name
                ,a.active               AS active
                ,1                      AS total
            FROM transaction.v_address a
            WHERE a.address_id='||i_address_id ||';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.address_id                 := REC.address_id;
            v_return.insert_ts                  := REC.insert_ts;
            v_return.update_ts                  := REC.update_ts;
            v_return.street                     := REC.street;
            v_return.unit_number                := REC.unit_number;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.postal_code                := REC.postal_code;
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.phone_number               := REC.phone_number;
            v_return.user_id                    := REC.user_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.active                     := REC.active;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

