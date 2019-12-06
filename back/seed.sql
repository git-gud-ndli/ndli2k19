-- seed users table
INSERT INTO internal.users (user_id, claim) VALUES
  (1, '{"picture":"toto.png","name":"toto"}'),
  (2, '{"picture":"jdoe.png","name":"John Doe"}'),
  (3, '{"picture":"aoe.png","name":"Wololo"}'),
  (4, '{"picture":"default.png","name":"Default"}');

-- seed tags
INSERT INTO internal.tags (tag_id, name, slug) VALUES
  (1, 'CROUS', 'crous'),
  (2, 'Finances', 'finances'),
  (3, 'Logement', 'logement'),
  (4, 'Transports', 'transports'),
  (5, 'Bourses', 'bourses'),
  (6, 'Formations', 'formations'),
  (7, 'Offres', 'offres');

-- seed posts
INSERT INTO internal.posts (post_id, user_id, content) VALUES
  (1, 2, 'Je veux dormir au chaud.'),
  (2, 3, '*** Magic is here ***');

-- seed questions
INSERT INTO internal.questions (question_id, post_id, title) VALUES
  (1, 1, 'Recherche logement pour cet hiver');

-- seed answers
INSERT INTO internal.answers (answer_id, post_id, question_id) VALUES
  (1, 2, 1);

-- seq
ALTER SEQUENCE internal.users_user_id_seq RESTART 5;
ALTER SEQUENCE internal.tags_tag_id_seq RESTART 8;
ALTER SEQUENCE internal.posts_post_id_seq RESTART 3;
ALTER SEQUENCE internal.questions_question_id_seq RESTART 2;
ALTER SEQUENCE internal.answers_answer_id_seq RESTART 2;
