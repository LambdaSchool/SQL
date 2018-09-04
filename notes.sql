-- Write queries that:
-- all create tables and inserts are on 'notesTables.sql'

-- Select all notes by an author's name.
SELECT *
FROM note
  LEFT OUTER JOIN
    author on note.author_id = author.id
WHERE author.name LIKE 'Steve'
;

-- Select author for a particular note by note ID.
SELECT author.name
FROM author, note
WHERE note.id = 13 AND note.author_id = author.id
;
-- Select the names of all the authors along with the number of notes they each have. (Hint: GROUP BY.)
SELECT author.name,
  count(note.id)
FROM author
  LEFT OUTER JOIN
    note ON note.author_id = author.id
GROUP BY author.name
;
-- Delete authors from the author table.
SELECT * FROM author;
DELETE FROM author WHERE ID=6;
SELECT * FROM author;
PRAGMA foreign_keys = ON;
DELETE FROM author WHERE ID=1;
SELECT * FROM author;
-- Note that SQLite doesn't enforce foreign key constrains by default. You have to enable them by running PRAGMA foreign_keys = ON; before your queries.

-- What happens when you try to delete an author with an existing note?
-- How can you prevent this?