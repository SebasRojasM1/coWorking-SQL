/*TABLES - Entities*/

/*ROOM*/
CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    name_room VARCHAR(100) NOT NULL,
    num_rows INTEGER NOT NULL,
    num_columns INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*WORKSPACES*/
CREATE TABLE workspaces (
    workspace_id SERIAL PRIMARY KEY,
    room_id INTEGER NOT NULL,
    row INTEGER NOT NULL,
    column INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);
