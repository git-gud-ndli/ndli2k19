CREATE OR REPLACE FUNCTION internal.current_user_id()
  RETURNS internal.users.user_id%type AS $$
    SELECT user_id
    FROM internal.users
    LIMIT 1
  $$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION api.add_question(title text, content text)
  RETURNS api.questions AS $$
    DECLARE
      c_user_id integer;
      c_post_id integer;
      c_question_id integer;
      value api.questions;
    BEGIN
      c_user_id := internal.current_user_id();

      -- create post
      INSERT INTO internal.posts (user_id, content) VALUES (c_user_id, $2)
      RETURNING post_id INTO c_post_id;

      INSERT INTO internal.questions (post_id, title) VALUES (c_post_id, $1)
      RETURNING question_id INTO c_question_id;

      SELECT * INTO value
        FROM api.questions
        WHERE questions.question_id = c_question_id;

      RETURN value;
    END;
  $$ LANGUAGE plpgsql;
