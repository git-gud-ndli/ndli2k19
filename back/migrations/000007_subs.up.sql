CREATE TABLE IF NOT EXISTS internal.tag_sub (
  user_id integer NOT NULL REFERENCES internal.users(user_id) ON DELETE CASCADE,
  tag_id integer NOT NULL REFERENCES internal.tags(tag_id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW(),
  PRIMARY KEY(user_id, tag_id)
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.tag_sub
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

CREATE TABLE IF NOT EXISTS internal.question_sub (
  user_id integer NOT NULL REFERENCES internal.users(user_id) ON DELETE CASCADE,
  question_id integer NOT NULL REFERENCES internal.questions(question_id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW(),
  PRIMARY KEY(user_id, question_id)
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.question_sub
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

CREATE OR REPLACE VIEW api.question_sub AS
  SELECT
    user_id,
    question_id
    FROM internal.question_sub;

CREATE OR REPLACE VIEW api.tag_sub AS
  SELECT
    user_id,
    tag_id
    FROM internal.tag_sub;

CREATE OR REPLACE FUNCTION api.add_question_sub(question_id integer)
  RETURNS api.question_sub AS $$
    DECLARE
      c_user_id integer;
      value api.question_sub;
    BEGIN
      c_user_id := internal.current_user_id();

      INSERT INTO internal.question_sub (user_id, question_id) VALUES (c_user_id, $1)
      ON CONFLICT (user_id, post_id) DO NOTHING;

      SELECT user_id, question_id INTO value
        FROM api.question_sub
        WHERE question_sub.user_id = c_user_id AND question_id = $1;

      RETURN value;
    END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION api.add_tag_sub(tag_id integer)
  RETURNS api.tag_sub AS $$
    DECLARE
      c_user_id integer;
      value api.tag_sub;
    BEGIN
      c_user_id := internal.current_user_id();

      INSERT INTO internal.tag_sub (user_id, tag_id) VALUES (c_user_id, $1)
      ON CONFLICT (user_id, post_id) DO NOTHING;

      SELECT user_id, tag_id INTO value
        FROM api.tag_sub
        WHERE tag_sub.user_id = c_user_id AND tag_id = $1;

      RETURN value;
    END;
  $$ LANGUAGE plpgsql;
