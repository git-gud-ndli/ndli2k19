CREATE OR REPLACE VIEW api.answers AS
  SELECT
    answers.answer_id,
    answers.post_id,
    posts.created_at,
    posts.updated_at,
    posts.user_id,
    posts.content
  FROM internal.answers
  JOIN internal.posts USING (post_id);
COMMENT ON VIEW api.answers IS
  E'@primaryKey answer_id';

CREATE OR REPLACE FUNCTION api.add_answer(question_id integer, content text)
  RETURNS api.answers AS $$
    DECLARE
      c_user_id integer;
      c_post_id integer;
      c_answer_id integer;
      value api.answers;
    BEGIN
      c_user_id := internal.current_user_id();

      -- create post
      INSERT INTO internal.posts (user_id, content) VALUES (c_user_id, $2)
      RETURNING post_id INTO c_post_id;

      -- create answer
      INSERT INTO internal.answers (post_id, question_id) VALUES (c_post_id, $1)
      RETURNING answer_id INTO c_answer_id;

      -- get the created answer
      SELECT * INTO value
        FROM api.answers
        WHERE answers.answer_id = c_answer_id;

      -- returns the created answer
      RETURN value;
    END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION api.answers_author(answer api.answers)
RETURNS api.users AS $$
  SELECT * FROM api.users
  WHERE answer.user_id = users.user_id
$$ LANGUAGE SQL STABLE;
