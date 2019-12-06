CREATE OR REPLACE FUNCTION api.answers_votes(answer api.answers)
RETURNS api.votes AS $$
  SELECT post_id, upvotes, downvotes
    FROM api.votes
    WHERE votes.post_id = answer.post_id
$$ LANGUAGE SQL STABLE;
