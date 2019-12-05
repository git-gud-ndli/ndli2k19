-- seed users table
INSERT INTO internal.users (user_id, claim) VALUES (1, '{"avatar":"toto.png","name":"toto"}');
INSERT INTO internal.users (user_id, claim) VALUES (2, '{"avatar":"jdoe.png","name":"John Doe"}');
INSERT INTO internal.users (user_id, claim) VALUES (3, '{"avatar":"aoe.png","name":"Wololo"}');
INSERT INTO internal.users (user_id, claim) VALUES (4, '{"avatar":"default.png","name":"Default"}');

-- seed tags
INSERT INTO internal.tags (tag_id, name, slug) VALUES (1, 'CROUS', 'crous');
INSERT INTO internal.tags (tag_id, name, slug) VALUES (2, 'Finances', 'finances');
INSERT INTO internal.tags (tag_id, name, slug) VALUES (3, 'Logement', 'logement');
INSERT INTO internal.tags (tag_id, name, slug) VALUES (4, 'Transports', 'transports');
INSERT INTO internal.tags (tag_id, name, slug) VALUES (5, 'Bourses', 'bourses');
INSERT INTO internal.tags (tag_id, name, slug) VALUES (6, 'Formations', 'formations');
INSERT INTO internal.tags (tag_id, name, slug) VALUES (7, 'Offres', 'offres');

-- seed posts
INSERT INTO internal.posts (post_id, user_id, content) VALUES (1, 2, 'Je veux dormir au chaud.');
INSERT INTO internal.posts (post_id, user_id, content) VALUES (2, 3, '*** Magic is here ***');

-- seed questions
INSERT INTO internal.questions (question_id, post_id, title) VALUES (1, 1, 'Recherche logement pour cet hiver');

-- seed answers
INSERT INTO internal.answers (answer_id, post_id, question_id) VALUES (1, 2, 1);
