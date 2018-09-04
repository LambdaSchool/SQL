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
  ``` sqlite> select * from album;
1|Super Awesome Album|1990
2|Super Funky Album|
3|Super Disco Album|1978
4|Super Hairband Album|1984
5|Super Dubstep Album|```

  * Show all albums made between 1975 and 1990.
  ``` sqlite> select * from album where release_year between 1975 and 1990;
1|Super Awesome Album|1990
3|Super Disco Album|1978
4|Super Hairband Album|1984```

  * Show all albums whose names start with `Super D`.
```sqlite> select * from album where title like '%Super D%';
3|Super Disco Album|1978
5|Super Dubstep Album| ```

  * Show all albums that have no release year.
```sqlite> select * from album where release_year is NULL;
2|Super Funky Album|
5|Super Dubstep Album| ```

* Write SQL `SELECT` queries that:
  * Show all track titles from `Super Funky Album`.

 ```sqlite> select title from track where album_id = 2;
Super Funky Track 1
Super Funky Track 2
Super Funky Track 3
Super Funky Track 4 ```

  * Same query as above, but rename the column from `title` to `Track_Title` in
    the output.

    ```sqlite> select title AS 'Track_Title' from track where album_id = 2;
Super Funky Track 1
Super Funky Track 2
Super Funky Track 3
Super Funky Track 4 ```

  * Select all album titles by `Han Solo`.
  ``` sqlite> select title from album where title = 'Han Solo';```

  * Select the average year all albums were released.
  ```sqlite> select avg(release_year) as 'Average year' from album;
1984.0 ```

  * Select the average year all albums by `Leia and the Ewoks` were released.
  ```sqlite> select AVG(release_year), A.name from album as AL
   ...> JOIN artist_album as AA ON AA.album_id = AL.album_id
   ...> JOIN artist as A ON A.artist_id = AA.artist_id
   ...> where A.name = 'Leia and the Ewoks';
AVG(release_year)|name
1990.0|Leia and the Ewoks ```

  * Select the number of artists.
  ``` sqlite> select count(artist_id) from artist;
3```

  * Select the number of tracks on `Super Dubstep Album`.
  ``` sqlite> select count(*) from album as A inner join track as T on A.album_id = T.album_id where T.title like
   ...> '%Super Dubstep%';
5```

### Exercises, Day 2

Create a database for taking notes.

* What are the columns that a note table needs? ID, title, content, user_id

* If you have a timestamp field, how do you auto-populate it with the date? timestamp DATE DEFAULT (datetime('now','localtime'))

* A note should have a foreign key pointing to an author in an author table.

* What columns are needed for the author table? ID, username, created_at

Write queries that:

* Insert authors to the author table.
sqlite> INSERT INTO user (username) VALUES ("adfaris");

* Insert notes to the note table.
```sqlite> INSERT INTO note (title, content) VALUES ("Note 1", "The content of note 1 goes in here"); ```

* Select all notes by an author's name.
select * from note N join user U  on U.user_id = N.user_id where U.username = 'adfaris;

* Select author for a particular note by note ID.

* Select the names of all the authors along with the number of notes they each have. (Hint: `GROUP BY`.)

* Delete authors from the author table.
  > Note that SQLite doesn't enforce foreign key constrains by default. You have
  > to enable them by running `PRAGMA foreign_keys = ON;` before your queries.
  
  * What happens when you try to delete an author with an existing note?
  ERROR: FOREIGN Key constraint failed
  * How can you prevent this?
  CASCADE DELETE

Submit a file `notes.sql` with the queries that build (`CREATE TABLE`/`INSERT`)
and query the database as noted above.

