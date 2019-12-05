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
CREATE TABLE IF NOT EXISTS api.users (
  user_id serial PRIMARY KEY,
  claim jsonb NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
    BEFORE UPDATE ON api.users
    FOR EACH ROW
    EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- posts
CREATE TABLE IF NOT EXISTS api.posts (
  post_id serial PRIMARY KEY,
  user_id integer REFERENCES api.users(user_id) ON DELETE SET NULL,
  content text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
    BEFORE UPDATE ON api.posts
    FOR EACH ROW
    EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- questions
CREATE TABLE IF NOT EXISTS api.questions (
  question_id serial PRIMARY KEY,
  post_id integer NOT NULL REFERENCES api.posts(post_id) ON DELETE CASCADE,
  title text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT NOW(),
  updated_at timestamptz NOT NULL DEFAULT NOW()
);

CREATE TRIGGER set_timestamp
    BEFORE UPDATE ON api.questions
    FOR EACH ROW
    EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- answers
CREATE TABLE IF NOT EXISTS api.answers (
  answer_id serial PRIMARY KEY,
  post_id integer NOT NULL REFERENCES api.posts(post_id) ON DELETE CASCADE,
  question_id integer NOT NULL REFERENCES api.questions(question_id) ON DELETE CASCADE
);

CREATE TRIGGER set_timestamp
    BEFORE UPDATE ON api.answers
    FOR EACH ROW
    EXECUTE PROCEDURE internal.trigger_set_timestamp();

-- devices
CREATE TABLE IF NOT EXISTS api.devices (
  device_id seria PRIMARY KEY,
  user_id integer NOT NULL REFERENCES api.users(user_id) ON DELETE CASCADE,
  endpoint varchar(1024)
);

CREATE OR REPLACE FUNCTION new_notify()
RETURNS trigger AS $$
BEGIN
   NOTIFY notif_new_post NEW.post_id;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER new_post
  BEFORE INSERT ON api.posts
  FOR EACH ROW
  EXECUTE PROCEDURE internal.new_notif();


-- permissions
GRANT USAGE ON SCHEMA api TO anonymous;
GRANT USAGE ON SCHEMA internal TO anonymous;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA api TO anonymous;
GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA internal TO anonymous;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA api TO anonymous;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA internal TO anonymous;
