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
    s.session_id,
    s.session_name,
    s.start_time,
    s.end_time,
    s.max_capacity,
    COUNT(r.reservation_id) AS num_reservations
FROM
    sessions s
LEFT JOIN
    reservations r ON s.session_id = r.session_id
GROUP BY
    s.session_id, s.session_name, s.start_time, s.end_time, s.max_capacity
ORDER BY
    num_reservations DESC;



/*View the sessions in order by the most available.*/
SELECT
    s.session_id,
    s.session_name,
    s.start_time,
    s.end_time,
    s.max_capacity,
    COUNT(r.reservation_id) AS num_reservations
FROM
    sessions s
LEFT JOIN
    reservations r ON s.session_id = r.session_id
GROUP BY
    s.session_id, s.session_name, s.start_time, s.end_time, s.max_capacity
ORDER BY
    num_reservations ASC;


    