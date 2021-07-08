# SQL

See [the Lambda page on Relational
Databases](https://github.com/LambdaSchool/Relational-Databases) for more
information. (Note that page is for PostgreSQL, but the SQL information is valid
here.)

## SQLite

SQLite is a popular, simple SQL database.

You can launch into a memory-only DB by running:

```
sqlite3
```

You can specify a persistent DB file with:

```
sqlite3 mydatabase.db
```

When you get to the prompt, you can type `.help` for commands.

Some helpful ones:

* `.mode column` turn on column output for `SELECT`.
* `.header on` turn on column headers for `SELECT`.
* `.read filename` execute the SQL in `filename`.
* `.open dbname` re-open a memory-only DB to a persistent file.
* `.quit` exit SQLite. (Note that if you're using a memory-only DB, all
  data is lost at this point.)

Another potentially useful third-party tool is [DB Browser for
SQLite](https://sqlitebrowser.org/), a GUI-based SQLite viewer and data
manipulator that can also run SQL queries.


## Create a Music Database

Make an albums table to hold album information:

```sql
CREATE TABLE album (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128) NOT NULL,
    release_year INTEGER
);
```

Make an artists table to hold artist information:

```sql
CREATE TABLE artist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);
```


### Exercises, Day 1

Before you begin, look at the queries in `setup.sql` to get a hint as to the
column names in the following tables. We'll use `setup.sql` later.

* Create a table called `track` that holds information about a music track. It should contain:
  * An autoincrementing `id`
  * A title (of type `VARCHAR`, probably)
  * A reference to an `id` in table `album` (the album the track is on). This
    should be a _foreign key_.

* Create a table called `artist_album` to connect artists to albums. (Note that
  an artist might have several albums and an album might be created by multiple
  artists.)
  * Use foreign keys for this, as well.
 
* Run the queries in the file `setup.sql`. This will populate the tables.
  * Fix any errors at this point by making sure your tables are correct.
  * `DROP TABLE` can be used to delete a table so you can recreate it with
    `CREATE TABLE`.

* Write SQL `SELECT` queries that:
  * Show all albums.
  
    SELECT * FROM album;

    id      title                release_year
    -----------------------------------------
    1       Super Awesome Album  1990        
    2       Super Funky Album                
    3       Super Disco Album    1978        
    4       Super Hairband Albu  1984        
    5       Super Dubstep Album       

  * Show all albums made between 1975 and 1990.

    SELECT * FROM album WHERE release_year > 1975 AND release_year < 1990;

    id          title              release_year
    ----------  -----------------  ------------
    3           Super Disco Album  1978        
    4           Super Hairband Al  1984        

  * Show all albums whose names start with `Super D`.

    SELECT * FROM album WHERE title LIKE '%Super D%';

    id          title              release_year
    ----------  -----------------  ------------
    3           Super Disco Album  1978        
    5           Super Dubstep Alb      

  * Show all albums that have no release year.

    SELECT * FROM ALBUM WHERE release_year is null;

    id          title              release_year
    ---------------------------------------
    2       Super Funky Album              
    5       Super Dubstep Alb    

* Write SQL `SELECT` queries that:
  * Show all track titles from `Super Funky Album`.

    SELECT track.title FROM track, album WHERE track.album_id = album.id AND album.title = "Super Funky Album";

    title              
    -------------------
    Super Funky Track 1
    Super Funky Track 2
    Super Funky Track 3
    Super Funky Track 4

  * Same query as above, but rename the column from `title` to `Track_Title` in
    the output.

    SELECT track.title FROM track, album WHERE track.album_id = album.id AND album.title = "Super Funky Album";

    Track Title        
    -------------------
    Super Funky Track 1
    Super Funky Track 2
    Super Funky Track 3
    Super Funky Track 4

  * Select all album titles by `Han Solo`.
    
    SELECT album.title, artist.name FROM album, artist_album, artist 
      WHERE artist_album.album_id = album.id 
      AND artist_album.artist_id = artist.id 
      AND artist.name = "Han Solo";
       
    title              name      
    -----------------  ----------
    Super Disco Album  Han Solo  
    Super Hairband Al  Han Solo    


  * Select the average year all albums were released.

     SELECT AVG(release_year) From album;

     AVG(release_year)
     -----------------
     1984.0  

  * Select the average year all albums by `Leia and the Ewoks` were released.

    SELECT AVG(release_year) FROM album, artist_album, artist
      WHERE artist_album.album_id = album.id 
      AND artist_album.artist_id = artist.id 
      AND artist.name = "Leia and the Ewoks";

    AVG(release_year)
    -----------------
    1990.0    

  * Select the number of artists.

    SELECT COUNT(name) FROM artist;

    COUNT(name)
    -----------
    3   

  * Select the number of tracks on `Super Dubstep Album`.

    SELECT COUNT(album.title) FROM track, album 
    WHERE album.title = "Super Dubstep Album" 
    AND track.album_id = album.id;

    COUNT(album.title)
    ------------
    5          
### Exercises, Day 2

Create a database for taking notes.

* What are the columns that a note table needs?

  A note table needs an id, text, and title columns.

* If you have a timestamp field, how do you auto-populate it with the date?

  I would use the built in TIMTSTAMP field and I would auto-populate it as

    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL to populate the field with current time.

* A note should have a foreign key pointing to an author in an author table.
    
* What columns are needed for the author table?

  The author table should have an id and name field.

Write queries that:

* Insert authors to the author table.

  INSERT INTO authors (name) VALUES ("alice");
  INSERT INTO authors (name) VALUES ("justin");
  INSERT INTO authors (name) VALUES ("bob");
  INSERT INTO authors (name) VALUES ("david");
  INSERT INTO authors (name) VALUES ("mark");
  INSERT INTO authors (name) VALUES ("travis");

* Insert notes to the note table.

  INSERT INTO notes (title, text, author) VALUES ("alice1", "alice note 1", 1);
  INSERT INTO notes (title, text, author) VALUES ("alice2", "alice note 1", 1);
  INSERT INTO notes (title, text, author) VALUES ("justin1", "justin note 1", 2);
  INSERT INTO notes (title, text, author) VALUES ("justin2", "justin note 2", 2);
  INSERT INTO notes (title, text, author) VALUES ("bob1", "bob note 1", 3);
  INSERT INTO notes (title, text, author) VALUES ("bob2", "bob note 2", 3);
  INSERT INTO notes (title, text, author) VALUES ("david1", "alice note 1", 4);
  INSERT INTO notes (title, text, author) VALUES ("david2", "alice note 2", 4);
  INSERT INTO notes (title, text, author) VALUES ("mark1", "alice note 1", 5);
  INSERT INTO notes (title, text, author) VALUES ("mark2", "alice note 2", 5);
  INSERT INTO notes (title, text, author) VALUES ("travis1", "alice note 1", 6);
  INSERT INTO notes (title, text, author) VALUES ("travis2", "alice note 2", 6);

* Select all notes by an author's name.

  Alice:
    SELECT title, text FROM notes, authors 
    WHERE notes.author = authors.id 
    AND authors.name ="alice";

    title       text        
    ----------  ------------
    alice1      alice note 1
    alice2      alice note 1

  Justin:
    SELECT title, text FROM notes, authors 
    WHERE notes.author = authors.id 
    AND authors.name = "justin";

    title       text         
    ----------  -------------
    justin1     justin note 1
    justin2     justin note 2

  Bob:
    SELECT title, text FROM notes, authors 
    WHERE notes.author = authors.id 
    AND authors.name = "bob";

    title       text      
    ----------  ----------
    bob1        bob note 1
    bob2        bob note 2

  David:
    SELECT title, text FROM notes, authors 
    WHERE notes.author = authors.id 
    AND authors.name = "david";

    title       text        
    ----------  ------------
    david1      alice note 1
    david2      alice note 2

  Travis:
    SELECT title, text FROM notes, authors 
    WHERE notes.author = authors.id 
    AND authors.name = "travis";

    title       text        
    ----------  ------------
    travis1     alice note 1
    travis2     alice note 2
  
* Select author for a particular note by note ID.
  
  SELECT name FROM notes, authors 
  WHERE notes.author = authors.id 
  AND notes.id = 1;

* Select the names of all the authors along with the number of notes they each have. (Hint: `GROUP BY`.)

SELECT name, COUNT(*) FROM authors, notes 
WHERE notes.author = authors.id 
GROUP BY notes.author;

* Delete authors from the author table.
  > Note that SQLite doesn't enforce foreign key constrains by default. You have
  > to enable them by running `PRAGMA foreign_keys = ON;` before your queries.
  
  * What happens when you try to delete an author with an existing note?
  * How can you prevent this?

Submit a file `notes.sql` with the queries that build (`CREATE TABLE`/`INSERT`)
and query the database as noted above.

