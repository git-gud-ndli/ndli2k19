CREATE OR REPLACE VIEW api.answers AS
  SELECT
    answers.answer_id,
    answers.post_id,
    posts.created_at,
    posts.updated_at,
    posts.user_id,
    posts.content,
    answers.question_id
  FROM internal.answers
  JOIN internal.posts USING (post_id);

CREATE OR REPLACE FUNCTION api.questions_answers(question api.questions)
RETURNS SETOF api.answers AS $$
  SELECT * FROM api.answers
  WHERE answers.question_id = question.question_id
$$ LANGUAGE SQL STABLE;
