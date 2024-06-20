/*View the list of occupied workspaces for a room in a session x.*/
SELECT * FROM workspaces LEFT JOIN reservations 
ON workspaces.workspace_id = reservations.workspace_id 
WHERE reservations.session_id = 9
AND (reservations.reservation_id IS NULL OR reservations.status = 'Accepted')