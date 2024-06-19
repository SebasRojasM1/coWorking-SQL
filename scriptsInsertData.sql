/*SCRIP Rooms*/
DO $$
DECLARE
    i INTEGER := 0;
    name_room VARCHAR(100);
    num_rows INTEGER;
    num_columns INTEGER;
BEGIN
    WHILE i < 100 LOOP
        name_room := 'Room ' || (i + 1);  -- Genera nombre de sala
        num_rows := floor(random() * (25 - 5 + 1) + 5);  -- Genera número aleatorio entre 5 y 25
        num_columns := floor(random() * (25 - 5 + 1) + 5);  -- Genera número aleatorio entre 5 y 25

        INSERT INTO rooms (name_room, num_rows, num_columns, created_at)
        VALUES (name_room, num_rows, num_columns, CURRENT_TIMESTAMP);

        i := i + 1;
    END LOOP;
END $$;


/* WORKSPACES Script  ERROR */
DO $$
DECLARE 
    room_count INTEGER;
    i INTEGER := 0;
    room_id INTEGER;
    n_row INTEGER;
    n_column INTEGER;
BEGIN
    SELECT COUNT(*) INTO room_count FROM rooms;
    WHILE i < 100 LOOP
        -- Seleccionar un rooms_id aleatorio
        room_id := (SELECT rooms_id FROM rooms OFFSET floor(random() * room_count) LIMIT 1);

        -- Seleccionar una fila y columna aleatoria dentro de los límites de la sala
        n_row := (SELECT floor(random() * num_rows) + 1 FROM rooms WHERE rooms_id = room_id);
        n_column := (SELECT floor(random() * num_columns) + 1 FROM rooms WHERE rooms_id = room_id);

        -- Insertar el registro en workspaces
        INSERT INTO workspaces (room_id, n_row, n_column) VALUES (room_id, n_row, n_column);
        i := i + 1;
    END LOOP;
END $$;





/* USERS Script*/
DO $$
DECLARE
    names TEXT[] := ARRAY['Sebastian', 'Maria', 'Luis', 'Camilo', 'Andrea', 'Luisa', 'Manuela', 'Frank', 'Pedro', 'Estefania', 'Marina', 'Esteban', 'Maximiliano', 'Lynda', 'Santiago', 'Carolina', 'Huber', 'Diana', 'Hernan'];
    lastNames TEXT[] := ARRAY['Rojas', 'Marin', 'Sanchez', 'Marquez', 'Arango', 'Garcia', 'Sanabria', 'Torres', 'Rodriguez', 'Martinez', 'Lopez', 'Parra', 'Yepes', 'Noreña', 'Cardona', 'Gomez', 'Piñeres'];
    domainArray TEXT[] := ARRAY['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com'];
    i INTEGER;
    randomName TEXT;
    randomLastName TEXT;
    randomEmail TEXT;
    randomPassword TEXT;
BEGIN
    FOR i IN 1..100 LOOP
        randomName := names[(floor(random() * array_length(names, 1)) + 1)::INTEGER];
        randomLastName := lastNames[(floor(random() * array_length(lastNames, 1)) + 1)::INTEGER];
        randomEmail := '';
        
        -- Generar un correo electrónico único
        WHILE randomEmail = '' LOOP
            randomEmail := lower(randomName || '.' || randomLastName || '@' || domainArray[(floor(random() * array_length(domainArray, 1)) + 1)::INTEGER]);
            
            -- Verificar si el correo electrónico generado ya existe en la tabla users
            PERFORM 1 FROM users WHERE email = randomEmail LIMIT 1;
            
            -- Si el correo electrónico existe, reiniciar el valor de randomEmail para intentar generar otro
            IF FOUND THEN
                randomEmail := '';
            END IF;
        END LOOP;
        
        randomPassword := md5(random()::text);  -- Genera una contraseña aleatoria (hash MD5)

        INSERT INTO users (name, lastname, email, password, created_at)
        VALUES (randomName, randomLastName, randomEmail, randomPassword, CURRENT_TIMESTAMP);
    END LOOP;
END $$;



/* SESSIONS Script*/
DO $$
DECLARE
    i INT := 1;
    random_start TIMESTAMP;
    random_end TIMESTAMP;
BEGIN
    WHILE i <= 100 LOOP
        -- Generar start_time aleatorio entre '2020-01-01 06:00:00' y '2023-12-31 16:59:59'
        random_start := TIMESTAMP '2024-06-19 06:00:00' + (random() * (TIMESTAMP '2024-08-01 16:59:59' - TIMESTAMP '2024-06-19 06:00:00'));

        -- Generar end_time aleatorio entre start_time y '2024-01-01 17:00:00'
        random_end := random_start + (random() * (TIMESTAMP '2024-01-01 17:00:00' - random_start));

        INSERT INTO sessions (start_time, end_time)
        VALUES (random_start, random_end);

        i := i + 1;
    END LOOP;
END $$;



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
    -- Contar el número de registros en las tablas workspaces, sessions y users
    SELECT COUNT(*) INTO workspace_count FROM workspaces;
    SELECT COUNT(*) INTO session_count FROM sessions;
    SELECT COUNT(*) INTO user_count FROM users;
    
    WHILE i < 100 LOOP
        -- Seleccionar IDs aleatorios de las tablas workspaces, sessions y users
        random_workspace_id := (SELECT workspace_id FROM workspaces OFFSET floor(random() * workspace_count) LIMIT 1);
        random_session_id := (SELECT session_id FROM sessions OFFSET floor(random() * session_count) LIMIT 1);
        random_user_id := (SELECT user_id FROM users OFFSET floor(random() * user_count) LIMIT 1);
        
        -- Seleccionar un status aleatorio
        random_status := statuses[floor(random() * array_length(statuses, 1) + 1)];
        
        -- Insertar el registro en reservations
        INSERT INTO reservations (workspace_id, session_id, user_id, status)
        VALUES (random_workspace_id, random_session_id, random_user_id, random_status);
        
        i := i + 1;
    END LOOP;
END $$;