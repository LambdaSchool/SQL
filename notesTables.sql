-- Create a database for taking notes.

-- What are the columns that a note table needs?
  -- need id, title, body, timestamp, auther
-- If you have a timestamp field, how do you auto-populate it with the date?
  -- created_on TIMESTAMP DEFAULT NOW()
-- A note should have a foreign key pointing to an author in an author table.
  -- author_id INT REFERENCES author(id)
-- What columns are needed for the author table?
  -- id, name


CREATE TABLE author (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE note (
id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(128) NOT NULL,
body TEXT NOT NULL,
author_id INT REFERENCES author(id),
created_on DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Insert authors to the author table.
INSERT INTO author (name) VALUES ('Steve');
INSERT INTO author (name) VALUES ('James');
INSERT INTO author (name) VALUES ('Peter');
INSERT INTO author (name) VALUES ('Paul');
INSERT INTO author (name) VALUES ('Mark');
INSERT INTO author (name) VALUES ('Luke');

-- Insert notes to the note table.
INSERT INTO note (title, body, author_id) VALUES ('this 0', 'longer version of this', 1);
INSERT INTO note (title, body, author_id) VALUES ('this 1', 'longer version of this', 1);
INSERT INTO note (title, body, author_id) VALUES ('this 2', 'longer version of this', 1);
INSERT INTO note (title, body, author_id) VALUES ('this 3', 'longer version of this', 2);
INSERT INTO note (title, body, author_id) VALUES ('this 4', 'longer version of this', 2);
INSERT INTO note (title, body, author_id) VALUES ('this 5', 'longer version of this', 2);
INSERT INTO note (title, body, author_id) VALUES ('this 6', 'longer version of this', 3);
INSERT INTO note (title, body, author_id) VALUES ('this 7', 'longer version of this', 3);
INSERT INTO note (title, body, author_id) VALUES ('this 8', 'longer version of this', 3);
INSERT INTO note (title, body, author_id) VALUES ('this 9', 'longer version of this', 4);
INSERT INTO note (title, body, author_id) VALUES ('this 10', 'longer version of this', 4);
INSERT INTO note (title, body, author_id) VALUES ('this 11', 'longer version of this', 4);
INSERT INTO note (title, body, author_id) VALUES ('this 12', 'longer version of this', 4);
INSERT INTO note (title, body, author_id) VALUES ('this 13', 'longer version of this', 4);