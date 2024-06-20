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
WHERE sessions.session_id = 14;