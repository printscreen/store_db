--REVOKE ALL ON SCHEMA public FROM store_db_web;

DROP USER IF EXISTS store_db_su;
DROP USER IF EXISTS store_db_web;

CREATE USER store_db_su  WITH PASSWORD '' IN ROLE postgres NOCREATEDB NOCREATEUSER; -- passwords needed
CREATE USER store_db_web WITH PASSWORD '';
GRANT USAGE ON SCHEMA public TO store_db_web;

/*
 * the only purpose of this function is to create the plpgsql language
 * if it does not already exist.  If you attempt to create the language
 * when it exists Postgres will throw an error... this is not desirable
 * as the db installer will fail to proceed if it sees the error.
 */
CREATE OR REPLACE FUNCTION make_plpgsql()
RETURNS VOID
LANGUAGE SQL
AS $$
CREATE LANGUAGE plpgsql;
$$;

SELECT
    CASE
    WHEN EXISTS(
        SELECT 1
        FROM pg_catalog.pg_language
        WHERE lanname='plpgsql'
    )
    THEN NULL
    ELSE make_plpgsql() END;

/* This is optional, but it's not required to stick around */
DROP FUNCTION make_plpgsql();
ALTER DATABASE store_db OWNER TO store_db_su;
