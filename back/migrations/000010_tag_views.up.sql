CREATE OR REPLACE VIEW api.tags AS
  SELECT
    tag_id,
    name,
    slug
    FROM internal.tags;
COMMENT ON VIEW api.tags IS
  E'@primaryKey tag_id';
