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