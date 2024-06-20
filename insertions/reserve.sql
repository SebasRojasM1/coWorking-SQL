/*A User can reserve a workspace in a session x.*/
INSERT INTO reservations (workspace_id, session_id, user_id, status, reservation_date)
VALUES (5, 23, 22, 'Accepted', CURRENT_TIMESTAMP);
