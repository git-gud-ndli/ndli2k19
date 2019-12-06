CREATE OR REPLACE FUNCTION api.add_upvote(post_id integer)
  RETURNS integer AS $$
    DECLARE
      c_user_id integer;
      value integer;
    BEGIN
      c_user_id := internal.current_user_id();

      -- create vote
      INSERT INTO internal.votes VALUES (c_user_id, $1, 'true');

      -- returns number of upvotes
      RETURN 0;
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
      INSERT INTO internal.votes VALUES (c_user_id, $1, 'false');

      -- returns number of downvotes
      RETURN 0;
    END;
  $$ LANGUAGE plpgsql;
