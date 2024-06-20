/*View the list of available workspaces for a room in a session x.*/
SELECT * FROM workspaces LEFT JOIN reservations 
ON workspaces.workspace_id = reservations.workspace_id 
WHERE reservations.session_id = 45
AND (reservations.reservation_id IS NULL OR reservations.status = 'Cancelled')
