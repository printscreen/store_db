DROP FUNCTION IF EXISTS get_kickstarter (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter (
    i_sort_field        BIGINT
  , i_offset            BIGINT
  , i_limit             BIGINT
)
RETURNS SETOF users.t_kickstarter
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_kickstarter;
    BEGIN
        
        v_sql := '
            SELECT 
                 k.kickstarter_id       AS kickstarter_id
                ,k.tier_id              AS tier_id
                ,k.name                 AS name
                ,k.first_name           AS first_name
                ,k.last_name            AS last_name
                ,k.password             AS password
                ,k.email                AS email
                ,k.prefered_email       AS prefered_email
                ,k.street               AS street
                ,k.unit_number          AS unit_number
                ,k.city                 AS city
                ,k.state                AS state
                ,k.postal_code          AS postal_code
                ,k.country_id           AS country_id
                ,k.country_name         AS country_name
                ,k.country_code         AS country_code
                ,k.phone_number         AS phone_number
                ,k.shirt_size           AS shirt_size
                ,k.shirt_sex            AS shirt_sex
                ,k.notes                AS notes
                ,k.hash                 AS hash
                ,k.last_sent_hash       AS last_sent_hash
                ,k.update_ts            AS update_ts
                ,k.verified             AS verified
                ,( SELECT COUNT(*)
                         FROM users.v_kickstarter k
                       )::BIGINT       AS total
            FROM users.v_kickstarter k
              ORDER BY ' || ABS(i_sort_field) || CASE WHEN i_sort_field < 0 THEN ' DESC ' ELSE ' ASC ' END ||
            ' OFFSET ' || i_offset ||
            ' LIMIT ' || i_limit || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_id             := REC.kickstarter_id;
            v_return.tier_id                    := REC.tier_id;
            v_return.name                       := REC.name;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.email                      := REC.email;
            v_return.prefered_email             := REC.prefered_email;
            v_return.password                   := REC.password;
            v_return.street                     := REC.street;
            v_return.unit_number                := REC.unit_number;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.postal_code                := REC.postal_code;
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.phone_number               := REC.phone_number;
            v_return.shirt_size                 := REC.shirt_size;
            v_return.shirt_sex                  := REC.shirt_sex;
            v_return.notes                      := REC.notes;
            v_return.hash                       := REC.hash;
            v_return.last_sent_hash             := REC.last_sent_hash;
            v_return.update_ts                  := REC.update_ts;
            v_return.verified                   := REC.verified;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_kickstarter (
    i_kickstarter_id    BIGINT
);
CREATE OR REPLACE FUNCTION get_kickstarter (
    i_kickstarter_id    BIGINT
)
RETURNS SETOF users.t_kickstarter
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_kickstarter;
    BEGIN
        IF i_kickstarter_id IS NULL THEN
            RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 k.kickstarter_id       AS kickstarter_id
                ,k.tier_id              AS tier_id
                ,k.name                 AS name
                ,k.first_name           AS first_name
                ,k.last_name            AS last_name
                ,k.email                AS email
                ,k.password             AS password
                ,k.prefered_email       AS prefered_email
                ,k.email                AS email
                ,k.street               AS street
                ,k.unit_number          AS unit_number
                ,k.city                 AS city
                ,k.state                AS state
                ,k.postal_code          AS postal_code
                ,k.country_id           AS country_id
                ,k.country_name         AS country_name
                ,k.country_code         AS country_code
                ,k.phone_number         AS phone_number
                ,k.shirt_size           AS shirt_size
                ,k.shirt_sex            AS shirt_sex
                ,k.notes                AS notes
                ,k.hash                 AS hash
                ,k.last_sent_hash       AS last_sent_hash
                ,k.update_ts            AS update_ts
                ,k.verified             AS verified
                ,1                      AS total
            FROM users.v_kickstarter k
            WHERE k.kickstarter_id='||i_kickstarter_id || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_id             := REC.kickstarter_id;
            v_return.tier_id                    := REC.tier_id;
            v_return.name                       := REC.name;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.email                      := REC.email;
            v_return.prefered_email             := REC.prefered_email;
            v_return.password                   := REC.password;
            v_return.street                     := REC.street;
            v_return.unit_number                := REC.unit_number;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.postal_code                := REC.postal_code;
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.phone_number               := REC.phone_number;
            v_return.shirt_size                 := REC.shirt_size;
            v_return.shirt_sex                  := REC.shirt_sex;
            v_return.notes                      := REC.notes;
            v_return.hash                       := REC.hash;
            v_return.last_sent_hash             := REC.last_sent_hash;
            v_return.update_ts                  := REC.update_ts;
            v_return.verified                   := REC.verified;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS get_kickstarter (
    i_email     VARCHAR
);
CREATE OR REPLACE FUNCTION get_kickstarter (
    i_email     VARCHAR
)
RETURNS SETOF users.t_kickstarter
SECURITY DEFINER AS
$_$
    DECLARE
        REC RECORD;
        v_sql TEXT;
        v_return users.t_kickstarter;
    BEGIN
        IF i_email IS NULL THEN
            RETURN;
        END IF;
        
        v_sql := '
            SELECT 
                 k.kickstarter_id       AS kickstarter_id
                ,k.tier_id              AS tier_id
                ,k.name                 AS name
                ,k.first_name           AS first_name
                ,k.last_name            AS last_name
                ,k.email                AS email
                ,k.password             AS password
                ,k.email                AS email
                ,k.prefered_email       AS prefered_email
                ,k.street               AS street
                ,k.unit_number          AS unit_number
                ,k.city                 AS city
                ,k.state                AS state
                ,k.postal_code          AS postal_code
                ,k.country_id           AS country_id
                ,k.country_name         AS country_name
                ,k.country_code         AS country_code
                ,k.phone_number         AS phone_number
                ,k.shirt_size           AS shirt_size
                ,k.shirt_sex            AS shirt_sex
                ,k.notes                AS notes
                ,k.hash                 AS hash
                ,k.last_sent_hash       AS last_sent_hash
                ,k.update_ts            AS update_ts
                ,k.verified             AS verified
                ,1                      AS total
            FROM users.v_kickstarter k
            WHERE k.email = '|| quote_literal(lower(i_email)) || ';';

        FOR REC IN
            EXECUTE v_sql
        LOOP
            v_return.kickstarter_id             := REC.kickstarter_id;
            v_return.name                       := REC.name;
            v_return.tier_id                    := REC.tier_id;
            v_return.first_name                 := REC.first_name;
            v_return.last_name                  := REC.last_name;
            v_return.email                      := REC.email;
            v_return.prefered_email             := REC.prefered_email;
            v_return.password                   := REC.password;
            v_return.street                     := REC.street;
            v_return.unit_number                := REC.unit_number;
            v_return.city                       := REC.city;
            v_return.state                      := REC.state;
            v_return.postal_code                := REC.postal_code;
            v_return.country_id                 := REC.country_id;
            v_return.country_name               := REC.country_name;
            v_return.country_code               := REC.country_code;
            v_return.phone_number               := REC.phone_number;
            v_return.shirt_size                 := REC.shirt_size;
            v_return.shirt_sex                  := REC.shirt_sex;
            v_return.notes                      := REC.notes;
            v_return.hash                       := REC.hash;
            v_return.last_sent_hash             := REC.last_sent_hash;
            v_return.update_ts                  := REC.update_ts;
            v_return.verified                   := REC.verified;
            v_return.total                      := REC.total;
            
            RETURN NEXT v_return;
        END LOOP;
    END;
$_$
LANGUAGE PLPGSQL;
