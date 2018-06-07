PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS track;
DROP TABLE IF EXISTS artist_album;

CREATE TABLE album (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128) NOT NULL,
    release_year INTEGER
);


CREATE TABLE artist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE track (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128) NOT NULL,
    album_id INTEGER REFERENCES album(id)
);

CREATE TABLE artist_album (
    artist_id INTEGER REFERENCES artist(id),
    album_id INTEGER REFERENCES album(id)
);

INSERT INTO artist_album (artist_id, album_id) VALUES (1, 5);
INSERT INTO artist_album (artist_id, album_id) VALUES (1, 2);
INSERT INTO artist_album (artist_id, album_id) VALUES (2, 1);
INSERT INTO artist_album (artist_id, album_id) VALUES (2, 2);
INSERT INTO artist_album (artist_id, album_id) VALUES (3, 3);
INSERT INTO artist_album (artist_id, album_id) VALUES (3, 4);

INSERT INTO track (title, album_id) VALUES ("Super Awesome Track 1", 1);
INSERT INTO track (title, album_id) VALUES ("Super Awesome Track 2", 1);
INSERT INTO track (title, album_id) VALUES ("Super Awesome Track 3", 1);
INSERT INTO track (title, album_id) VALUES ("Super Awesome Track 4", 1);
INSERT INTO track (title, album_id) VALUES ("Super Awesome Track 5", 1);

INSERT INTO track (title, album_id) VALUES ("Super Funky Track 1", 2);
INSERT INTO track (title, album_id) VALUES ("Super Funky Track 2", 2);
INSERT INTO track (title, album_id) VALUES ("Super Funky Track 3", 2);
INSERT INTO track (title, album_id) VALUES ("Super Funky Track 4", 2);

INSERT INTO track (title, album_id) VALUES ("Super Disco Track 1", 3);
INSERT INTO track (title, album_id) VALUES ("Super Disco Track 2", 3);
INSERT INTO track (title, album_id) VALUES ("Super Disco Track 3", 3);

INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 1", 4);
INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 2", 4);
INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 3", 4);
INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 4", 4);
INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 5", 4);
INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 6", 4);
INSERT INTO track (title, album_id) VALUES ("Super Hairband Track 7", 4);

INSERT INTO track (title, album_id) VALUES ("Super Dubstep Track 1", 5);
INSERT INTO track (title, album_id) VALUES ("Super Dubstep Track 2", 5);
INSERT INTO track (title, album_id) VALUES ("Super Dubstep Track 3", 5);
INSERT INTO track (title, album_id) VALUES ("Super Dubstep Track 4", 5);
INSERT INTO track (title, album_id) VALUES ("Super Dubstep Track 5", 5);

-- Show all albums
SELECT * FROM album

-- Show all albums made between 1975 and 1990.
SELECT * FROM album 
    WHERE release_year >= 1975 
    AND release_year <= 1990;

--Show all albums whose name start with Super D
SELECT * FROM album WHERE title LIKE 'Super D%';

-- Show all albums that have no release year.
SELECT * FROM album WHERE release_year IS NULL;



-- Show all track titles from `Super Funky Album`.
SELECT track.title FROM album, track
    WHERE track.album_id = album.id
    AND album.title = "Super Funky Album";

-- Same query as above, but rename the column from `title` to `Track_Title` in the output.
SELECT track.title AS 'Track_Title' FROM album, track
    WHERE track.album_id = album.id
    AND album.title = "Super Funky Album";


-- Select all album titles by `Han Solo`.
SELECT album.title FROM album, artist, artist_album
    WHERE artist.name = "Han Solo"
    AND artist_album.artist_id = artist.id
    AND artist_album.album_id = album.id;

-- Select the average year all albums were released.
SELECT avg(release_year) FROM album;

-- Select the average year all albums by `Leia and the Ewoks` were released.
SELECT avg(release_year) FROM album, artist, artist_album
    WHERE artist.name = "Leia and the Ewoks"
    AND artist_album.artist_id = artist.id
    AND artist_album.album_id = album.id;

-- Select the number of artists.
SELECT count(*) FROM artist;

-- Select the number of tracks on `Super Dubstep Album`.
SELECT count(*) FROM album, track
    WHERE track.album_id = album.id
    AND album.title = "Super Dubstep Album";