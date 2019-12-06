DROP TABLE IF EXISTS api.devices;

CREATE TABLE IF NOT EXISTS internal.devices (
  device_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES internal.users(user_id) ON DELETE CASCADE,
  endpoint TEXT NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.devices
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

CREATE OR REPLACE FUNCTION api.add_device(endpoint text) RETURNS void AS $$
  DECLARE
    c_user_id integer;
  BEGIN
    c_user_id := internal.current_user_id();

    INSERT INTO internal.devices (user_id, endpoint)
      VALUES (c_user_id, $1);
  END;
$$ LANGUAGE plpgsql;
