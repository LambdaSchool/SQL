-- select all albums
SELECT *
FROM album;

-- Show all albums made between 1975 and 1990. 
SELECT *
FROM album
WHERE release_year > 1975 AND release_year < 1990;

-- Show all albums whose names start with Super D.
SELECT *
FROM album
WHERE title LIKE 'Super D%';

-- Show all albums that have no release year.

SELECT *
FROM album
WHERE release_year IS NULL;


-- Show all track titles from Super Funky Album.
SELECT T.id, T.title as Track_Title, T.album_id
FROM track AS T, album
WHERE album.title = 'Super Funky Album' AND album_id = album.id;
-- Same query as above, but rename the column from title to Track_Title in the output.
SELECT T.id, T.title as Track_Title, T.album_id
FROM track AS T
  LEFT OUTER JOIN album A
    ON T.album_id = A.id
WHERE A.title = 'Super Funky Album'; 

-- Select all album titles by Han Solo.
SELECT * 
FROM artist, artist_album 
WHERE artist.id = artist_id AND artist.name= 'Han Solo';

-- Select the average year all albums were released.
SELECT AVG(release_year) as average_release
FROM Album;

-- Select the average year all albums by Leia and the Ewoks were released.
SELECT AVG(album.release_year)
FROM album, artist, artist_album
WHERE artist.id = artist_album.artist_id 
  AND album.id = artist_album.album_id
  AND artist.name = 'Leia and the Ewoks'
;

-- Select the number of artists.
SELECT COUNT()
FROM artist;
-- Select the number of tracks on Super Dubstep Album.

SELECT COUNT()
FROM track AS T, album
WHERE album.title LIKE 'Super Dub%' AND album_id = album.id;