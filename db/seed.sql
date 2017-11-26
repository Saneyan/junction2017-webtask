INSERT INTO "question" (content) VALUES ('Do you want to work in Helsinki or other cities in Finland?');
INSERT INTO "option" (question_id, content) VALUES (1, 'Helsinki');
INSERT INTO "option" (question_id, content) VALUES (1, 'Other cities');

INSERT INTO "question" (content) VALUES ('Length of the working term you would prefer?');
INSERT INTO "option" (question_id, content) VALUES (2, 'less than 3 months');
INSERT INTO "option" (question_id, content) VALUES (2, 'more than 3 months');

INSERT INTO "question" (content) VALUES ('Which one do you prefer');
INSERT INTO "option" (question_id, content) VALUES (3, 'Conversations with co-workers');
INSERT INTO "option" (question_id, content) VALUES (3, 'Focus and silence');

INSERT INTO "question" (content) VALUES ('Startup or a more established company?');
INSERT INTO "option" (question_id, content) VALUES (3, 'Startup');
INSERT INTO "option" (question_id, content) VALUES (3, 'Established company');

INSERT INTO "user" (name, age) VALUES ('test', 25);
