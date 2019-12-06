CREATE TABLE IF NOT EXISTS internal.votes (
  user_id integer NOT NULL REFERENCES internal.users(user_id) ON DELETE CASCADE,
  post_id integer NOT NULL REFERENCES internal.posts(post_id) ON DELETE CASCADE,
  is_up boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW(),
  PRIMARY KEY(user_id, post_id)
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.votes
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

CREATE OR REPLACE VIEW api.votes AS
  SELECT
    post_id,
    COUNT(CASE WHEN is_up = 'true' THEN 1 END) AS upvotes,
    COUNT(CASE WHEN is_up = 'false' THEN 1 END) AS downvotes
    FROM internal.votes
    GROUP BY post_id;

CREATE OR REPLACE FUNCTION api.answer_votes(answer api.answers)
RETURNS api.votes AS $$
  SELECT post_id, upvotes, downvotes
    FROM api.votes
    WHERE votes.post_id = answer.post_id
$$ LANGUAGE SQL STABLE;

CREATE OR REPLACE FUNCTION api.add_upvote(post_id integer)
  RETURNS integer AS $$
    DECLARE
      c_user_id integer;
      value integer;
    BEGIN
      c_user_id := internal.current_user_id();

      -- create vote
      INSERT INTO internal.votes (user_id, post_id, is_up) VALUES (c_user_id, $1, 'true')
      ON CONFLICT (user_id, post_id) DO UPDATE SET is_up = 'true';

      -- get the number of upvotes
      SELECT COUNT (*) INTO value
        FROM internal.votes
        WHERE votes.post_id = $1 AND is_up = 'true';

      -- returns number of upvotes
      RETURN value;
    END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION api.add_downvote(post_id integer)
  RETURNS integer AS $$
    DECLARE
      c_user_id integer;
      value integer;
    BEGIN
      c_user_id := internal.current_user_id();

      -- create vote
      INSERT INTO internal.votes (user_id, post_id, is_up) VALUES (c_user_id, $1, 'false')
      ON CONFLICT (user_id, post_id) DO UPDATE SET is_up = 'false';

      -- get the number of downvotes
      SELECT COUNT (*) INTO value
        FROM internal.votes
        WHERE votes.post_id = $1 AND is_up = 'false';

      -- returns number of downvotes
      RETURN value;
    END;
  $$ LANGUAGE plpgsql;
