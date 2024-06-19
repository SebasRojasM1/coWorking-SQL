/*TABLES - Entities*/

/*ROOM*/
CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    name_room VARCHAR(100) NOT NULL,
    num_rows INTEGER NOT NULL,
    num_columns INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);