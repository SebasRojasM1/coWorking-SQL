/*View the list of available workspaces for a room in a session x.*/
SELECT * FROM workspaces LEFT JOIN reservations 
ON workspaces.workspace_id = reservations.workspace_id 
WHERE reservations.session_id = 45
AND (reservations.reservation_id IS NULL OR reservations.status = 'Cancelled')



/*View the list of occupied workspaces for a room in a session x.*/
SELECT * FROM workspaces LEFT JOIN reservations 
ON workspaces.workspace_id = reservations.workspace_id 
WHERE reservations.session_id = 9
AND (reservations.reservation_id IS NULL OR reservations.status = 'Accepted')



/*View the sessions in order of the busiest.*/
SELECT
    sessions.session_id,
    sessions.session_name,
    sessions.start_time,
    sessions.end_time,
    sessions.max_capacity,
    COUNT(reservations.reservation_id) AS num_reservations
FROM sessions
LEFT JOIN reservations ON sessions.session_id = reservations.session_id
GROUP BY sessions.session_id, sessions.session_name, sessions.start_time, sessions.end_time, sessions.max_capacity
ORDER BY num_reservations DESC;


/*View the sessions in order by the most available.*/
SELECT
    sessions.session_id,
    sessions.session_name,
    sessions.start_time,
    sessions.end_time,
    sessions.max_capacity,
    COUNT(reservations.reservation_id) AS num_reservations
FROM sessions
LEFT JOIN reservations ON sessions.session_id = reservations.session_id
GROUP BY sessions.session_id, sessions.session_name, sessions.start_time, sessions.end_time, sessions.max_capacity
ORDER BY num_reservations ASC;


/* View the list of workspaces assigned to a user. */
SELECT 
    users.user_id, 
    users.name AS name, 
    users.lastname AS lastname, 
    workspaces.workspace_id, 
    workspaces.n_row AS row_number, 
    workspaces.n_column AS column_number, 
    reservations.status
FROM users
JOIN reservations ON users.user_id = reservations.user_id
JOIN workspaces ON reservations.workspace_id = workspaces.workspace_id
WHERE users.user_id = 25;


/* View the list of workspaces assigned to a session. */
SELECT 
    sessions.session_id, 
    sessions.session_name, 
    workspaces.workspace_id, 
    workspaces.n_row AS row_number, 
    workspaces.n_column AS column_number
FROM sessions
JOIN reservations ON sessions.session_id = reservations.session_id
JOIN workspaces ON reservations.workspace_id = workspaces.workspace_id
WHERE sessions.session_id = 75;