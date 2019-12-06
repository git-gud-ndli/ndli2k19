CREATE OR REPLACE FUNCTION internal.current_user_id()
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
  DECLARE
    value integer;
    claims jsonb;
  BEGIN
    -- fetch the claims from the settings
    claims := current_setting('jwt.claims')::jsonb;

    -- find existing user
    SELECT users.user_id INTO value
    FROM internal.users
    WHERE (users.claim->>'sub') = (claims->>'sub')
    LIMIT 1;

    -- update or create the claim
    IF NOT FOUND THEN
      INSERT INTO internal.users (claim) VALUES (claims) RETURNING user_id INTO value;
    ELSE
      UPDATE internal.users SET claim = claims WHERE users.user_id = value;
    END IF;

    RETURN value;
  EXCEPTION WHEN OTHERS THEN
    RETURN null;
  END;
$function$
