-- *****************************************************************************
-- This script contains INSERT statements for populating tables with seed data
-- *****************************************************************************

BEGIN;
TRUNCATE app_user RESTART IDENTITY CASCADE;
TRUNCATE tag RESTART IDENTITY CASCADE;
TRUNCATE flashcard RESTART IDENTITY CASCADE;
TRUNCATE deck RESTART IDENTITY CASCADE;

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user1');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user2');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user3');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user4');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user5');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user6');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user7');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user8');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user9');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user10');

INSERT INTO app_user (email, password, salt, user_name) 
VALUES ('firstuser@test.com', 'Itk26/WpSvlUq+cPG3dsuw==', 'EX1afaNPjIUWVghpyquscc2f2Zo1IlCbtlwuQYIZcP1afwr8i2KqjpHokQTZZ2VaYiNUv95Qf0SIzg38HkHpbJ68a9BxVjN2efDf9t7ogXoELuLLMmtS0y7nsgfUYaDSf3C6OofrfbsFTTTMxO+Yb4I6upz9X8BMi3w74WZ6g5Q=
', 'user11');

INSERT INTO tag (name, tag_id) 
VALUES ('Art', 1);

INSERT INTO tag (name, tag_id) 
VALUES ('Computer Science', 2);

INSERT INTO tag (name, tag_id) 
VALUES ('Economics', 3);

INSERT INTO tag (name, tag_id) 
VALUES ('English', 4);

INSERT INTO tag (name, tag_id) 
VALUES ('Geography', 5);

INSERT INTO tag (name, tag_id) 
VALUES ('History', 6);

INSERT INTO tag (name, tag_id) 
VALUES ('Math', 7);

INSERT INTO tag (name, tag_id) 
VALUES ('Misc.', 8);

INSERT INTO tag (name, tag_id) 
VALUES ('Music', 9);

INSERT INTO tag (name, tag_id) 
VALUES ('Reading/Writing', 10);

INSERT INTO tag (name, tag_id) 
VALUES ('Science', 11);

INSERT INTO tag (name, tag_id) 
VALUES ('Social Science', 12);

INSERT INTO tag (name, tag_id) 
VALUES ('Spanish', 13);

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01,  'Who was the first president of the US?', 'George Washington');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, 'Who was the second president of the US?', 'John Adams');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, 'Who founded the first central bank of the United States?', 'Alexander Hamilton');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, 'What year was the U.S. Declaration of Independence signed?', '1776');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, 'What was the primary cause of the U.S. Civil War?', 'Slavery');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, 'What day will live in infamy?', 'December 7th, 1941');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, 'Who was the seventeenth president of the US', 'Andrew Johnson');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, '4+4', '8');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, '4x4', '16');

INSERT INTO flashcard (user_id, front_text, back_text) 
VALUES (01, '4+4+4', '12');

INSERT INTO deck (user_id, name, description) 
VALUES (01, 'History Deck', 'The most important historical information in one place');

INSERT INTO deck (user_id, name, description) 
VALUES (01, 'Math', 'All the maths');

INSERT INTO card_deck (card_id, deck_id) 
VALUES (01,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (02,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (03,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (04,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (05,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (06,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (07,01);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (08,02);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (09,02);

INSERT INTO card_deck (card_id, deck_id) 
VALUES (10,02);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (01,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (02,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (03,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (04,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (05,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (05,11);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (06,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (07,06);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (08,07);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (09,07);

INSERT INTO card_tag (card_id, tag_id) 
VALUES (10,07);

COMMIT;