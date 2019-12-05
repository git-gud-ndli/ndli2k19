-- schema creation
CREATE SCHEMA api;
CREATE SCHEMA internal;

-- role creation
CREATE ROLE anonymous;

-- triggers
CREATE FUNCTION internal.trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- users
CREATE TABLE IF NOT EXISTS internal.users (
  user_id serial PRIMARY KEY,
  claim jsonb NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.users
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- posts
CREATE TABLE IF NOT EXISTS internal.posts (
  post_id serial PRIMARY KEY,
  user_id integer REFERENCES internal.users(user_id) ON DELETE SET NULL,
  content text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.posts
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- questions
CREATE TABLE IF NOT EXISTS internal.questions (
  question_id serial PRIMARY KEY,
  post_id integer NOT NULL REFERENCES internal.posts(post_id) ON DELETE CASCADE,
  title text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.questions
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- answers
CREATE TABLE IF NOT EXISTS internal.answers (
  answer_id serial PRIMARY KEY,
  post_id integer NOT NULL REFERENCES internal.posts(post_id) ON DELETE CASCADE,
  question_id integer NOT NULL REFERENCES internal.questions(question_id) ON DELETE CASCADE
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.answers
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- tags
CREATE TABLE IF NOT EXISTS internal.tags (
  tag_id serial PRIMARY KEY,
  name text,
  slug text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
  BEFORE UPDATE ON internal.tags
  FOR EACH ROW
  EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- questions <-> tags
CREATE TABLE IF NOT EXISTS internal.questions_tags (
  question_id integer NOT NULL REFERENCES internal.questions(question_id) ON DELETE CASCADE,
  tag_id integer NOT NULL REFERENCES internal.tags(tag_id) ON DELETE CASCADE
);

-- permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA api TO anonymous;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA internal TO anonymous;
