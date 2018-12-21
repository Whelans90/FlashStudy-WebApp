-- *************************************************************************************************
-- This script creates all of the database objects (tables, sequences, etc) for the database
-- *************************************************************************************************

BEGIN;

-- CREATE statements go here
DROP TABLE IF EXISTS card_deck;
DROP TABLE IF EXISTS card_tag;
DROP TABLE IF EXISTS flashcard;
DROP TABLE IF EXISTS deck;
DROP SEQUENCE IF EXISTS seq_deck_id;
DROP SEQUENCE IF EXISTS seq_card_id;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS app_user;

CREATE TABLE app_user (
  user_id SERIAL PRIMARY KEY,
  user_name varchar(32) NOT NULL UNIQUE,
  password varchar(32) NOT NULL,
  role varchar(32),
  salt varchar(255) NOT NULL,
  email varchar(32)
);

CREATE TABLE tag (
  tag_id SERIAL PRIMARY KEY,
  name varchar(32)
);

CREATE SEQUENCE seq_card_id;

CREATE TABLE flashcard (
  card_id INTEGER PRIMARY KEY DEFAULT NEXTVAL('seq_card_id'),
  user_id INTEGER REFERENCES app_user(user_id),
  front_text text,
  back_text text
);

CREATE TABLE card_tag (
  card_id INTEGER REFERENCES flashcard(card_id),
  tag_id INTEGER REFERENCES tag(tag_id),
  CONSTRAINT pk_card_tag_card_id_deck_id PRIMARY KEY (card_id, tag_id)
);

CREATE SEQUENCE seq_deck_id;

CREATE TABLE deck (
  deck_id INTEGER PRIMARY KEY DEFAULT NEXTVAL('seq_deck_id'),
  user_id INTEGER REFERENCES app_user(user_id),
  name varchar(32) NOT NULL,
  description text
);

CREATE TABLE card_deck (
  card_id INTEGER REFERENCES flashcard(card_id),
  deck_id INTEGER REFERENCES deck(deck_id),
  isRight BOOLEAN,
  CONSTRAINT pk_card_deck_card_id_deck_id PRIMARY KEY (card_id, deck_id)
);

COMMIT;