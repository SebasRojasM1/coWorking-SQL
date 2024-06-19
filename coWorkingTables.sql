-- Active: 1718815659607@@bgnwijf7xgjtl39fgrro-postgresql.services.clever-cloud.com@50013
/*TABLES - Entities*/

SELECT * FROM workspaces


/*ROOM*/
CREATE TABLE rooms (
    rooms_id SERIAL PRIMARY KEY,
    name_room VARCHAR(100) NOT NULL,
    num_rows INTEGER NOT NULL,
    num_columns INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DROP TABLE rooms


/*WORKSPACES*/
CREATE TABLE workspaces (
    workspace_id SERIAL PRIMARY KEY,
    room_id INTEGER NOT NULL,
    n_row INTEGER NOT NULL,
    n_column INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(rooms_id)
);


/* SESSIONS */
CREATE TABLE sessions (
    session_id SERIAL PRIMARY KEY,
    session_name VARCHAR(100),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    max_capacity INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/* USERS */
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* RESERVATIONS */
CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    workspace_id INTEGER NOT NULL,
    session_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (workspace_id) REFERENCES workspaces(workspace_id),
    FOREIGN KEY (session_id) REFERENCES sessions(session_id)
);


SELECT * FROM sessions

DROP TABLE rooms

DROP TABLE workspaces

DROP TABLE sessions

DROP TABLE USERS

DROP TABLE reservations