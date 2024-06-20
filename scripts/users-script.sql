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