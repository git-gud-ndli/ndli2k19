CREATE TYPE resource_type AS ENUM ('link', 'file');

CREATE TABLE IF NOT EXISTS internal.resources (
  resource_id serial PRIMARY KEY,
  name text NOT NULL,
  url text NOT NULL,
  type resource_type NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.resources
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

CREATE OR REPLACE VIEW api.resources AS
  SELECT
    resource_id,
    name,
    url,
    type
    FROM internal.resources;
COMMENT ON VIEW api.resources IS
  E'@primaryKey resource_id';

CREATE TABLE IF NOT EXISTS internal.resource_tag (
  resource_id integer NOT NULL REFERENCES internal.resources(resource_id) ON DELETE CASCADE,
  tag_id integer NOT NULL REFERENCES internal.tags(tag_id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW(),
  PRIMARY KEY(resource_id, tag_id)
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.resource_tag
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

CREATE OR REPLACE VIEW api.resource_tag AS
  SELECT
    resource_id,
    tag_id
    FROM internal.resource_tag;

CREATE OR REPLACE FUNCTION api.add_resource_tag(resource_id integer, tag_id integer)
  RETURNS api.resource_tag AS $$
    DECLARE
      value api.resource_tag;
    BEGIN
      INSERT INTO internal.resource_tag (resource_id, tag_id) VALUES ($1, $2)
      ON CONFLICT (resource_id, post_id) DO NOTHING;

      SELECT resource_id, tag_id INTO value
        FROM api.resource_tag
        WHERE resource_tag.resource_id = $1 AND resource_tag.tag_id = $2;

      RETURN value;
    END;
  $$ LANGUAGE plpgsql;
