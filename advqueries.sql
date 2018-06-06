PRAGMA foreign_keys = ON; -- SQLite Only

DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS object;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS room_object;

CREATE TABLE player (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    room_id INTEGER REFERENCES room(id) -- FOREIGN KEY
);

CREATE TABLE object (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
);

CREATE TABLE room (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL,
    description VARCHAR(1024), 
    w_to INTEGER REFERENCES room(id),
    e_to INTEGER REFERENCES room(id),
    s_to INTEGER REFERENCES room(id),
    n_to INTEGER REFERENCES room(id)
);

CREATE TABLE room_object (
    room_id INTEGER REFERENCES room(id),
    object_id INTEGER REFERENCES object(id)
);

INSERT INTO room (name, description) VALUES ("Foyer", "This is where the adventure begins!");
INSERT INTO room (name, description) VALUES ("Hallway", "Between the foyer and the rest of the house.");

UPDATE room SET n_to=2 WHERE id=1;
UPDATE room SET s_to=1 WHERE id=2;

INSERT INTO player (name, room_id) VALUES ("Amanda", 1);

INSERT INTO object (name) VALUES ("Plastic Sword");
INSERT INTO object (name) VALUES ("Plastic Shield");

INSERT INTO room_object (room_id, object_id) VALUES (1,1); -- Sword in the foyer
INSERT INTO room_object (room_id, object_id) VALUES (2,1); -- Sword in the hallway
INSERT INTO room_object (room_id, object_id) VALUES (2,2); -- Shield in the hallway

SELECT room.name, description FROM player, room
    WHERE player.room_id = room.id AND -- This is the JOIN
    player.id = 1;