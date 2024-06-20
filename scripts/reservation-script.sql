/*RESERVATIONS Script*/
DO $$
DECLARE
    i INTEGER := 0;
    workspace_count INTEGER;
    session_count INTEGER;
    user_count INTEGER;
    random_workspace_id INTEGER;
    random_session_id INTEGER;
    random_user_id INTEGER;
    statuses TEXT[] := ARRAY['Cancelled', 'In progress', 'Accepted'];
    random_status TEXT;
BEGIN
    SELECT COUNT(*) INTO workspace_count FROM workspaces;
    SELECT COUNT(*) INTO session_count FROM sessions;
    SELECT COUNT(*) INTO user_count FROM users;
    
    WHILE i < 100 LOOP
        random_workspace_id := (SELECT workspace_id FROM workspaces OFFSET floor(random() * workspace_count) LIMIT 1);
        random_session_id := (SELECT session_id FROM sessions OFFSET floor(random() * session_count) LIMIT 1);
        random_user_id := (SELECT user_id FROM users OFFSET floor(random() * user_count) LIMIT 1);
        
        random_status := statuses[floor(random() * array_length(statuses, 1) + 1)];
        
        INSERT INTO reservations (workspace_id, session_id, user_id, status)
        VALUES (random_workspace_id, random_session_id, random_user_id, random_status);
        
        i := i + 1;
    END LOOP;
END $$;