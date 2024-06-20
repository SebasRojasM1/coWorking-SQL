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
