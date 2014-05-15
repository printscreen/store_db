DROP FUNCTION IF EXISTS authenticate (
    i_email     VARCHAR(255)
  , i_password  VARCHAR(32)
);
CREATE OR REPLACE FUNCTION authenticate (
    i_email     VARCHAR(255)
  , i_password  VARCHAR(32)
)
RETURNS BIGINT
SECURITY DEFINER AS
$_$
    SELECT COALESCE(
        (SELECT user_id 
        FROM users.user 
        WHERE email = $1 
            AND password = (SELECT hash_password AS password FROM hash_password($2)))
      , NULL
    );
$_$
LANGUAGE SQL;
