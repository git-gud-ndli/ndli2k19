-- schema creation
CREATE SCHEMA api;
CREATE SCHEMA internal;

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

-- views
CREATE OR REPLACE VIEW api.questions AS
  SELECT
    questions.question_id,
    questions.post_id,
    questions.title,
    posts.created_at,
    posts.updated_at,
    posts.user_id,
    posts.content
  FROM internal.questions
  JOIN internal.posts USING (post_id);

CREATE OR REPLACE VIEW api.users AS
  SELECT
    users.user_id,
    users.claim->>'picture' AS avatar,
    users.claim->>'name' AS name
  FROM internal.users;

-- devices
CREATE TABLE IF NOT EXISTS api.devices (
  device_id serial PRIMARY KEY,
  user_id integer NOT NULL REFERENCES internal.users(user_id) ON DELETE CASCADE,
  endpoint varchar(1024)
);

CREATE OR REPLACE FUNCTION internal.new_notify()
RETURNS trigger AS $$
BEGIN
   PERFORM pg_notify('notif_new_post', NEW.post_id);
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER new_post
  BEFORE INSERT ON internal.posts
  FOR EACH ROW
  EXECUTE PROCEDURE internal.new_notify();

CREATE OR REPLACE FUNCTION api.questions_author(question api.questions)
RETURNS api.users AS $$
  SELECT * FROM api.users
  WHERE question.user_id = users.user_id
$$ LANGUAGE SQL STABLE;

-- permissions
GRANT USAGE ON SCHEMA api TO anonymous;
GRANT USAGE ON SCHEMA internal TO anonymous;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA api TO anonymous;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA internal TO anonymous;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api TO anonymous;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA internal TO anonymous;

