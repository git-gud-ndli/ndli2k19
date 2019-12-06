ALTER TABLE internal.devices ADD COLUMN p256dh TEXT;
ALTER TABLE internal.devices ADD COLUMN auth TEXT;

DROP FUNCTION api.add_device;

CREATE OR REPLACE FUNCTION api.add_device(endpoint text, key text, token text) RETURNS void AS $$
  DECLARE
    c_user_id integer;
  BEGIN
    c_user_id := internal.current_user_id();

    INSERT INTO internal.devices (user_id, endpoint, p256dh, auth)
      VALUES (c_user_id, $1, $2, $3);
  END;
$$ LANGUAGE plpgsql;
