/* SESSIONS Script*/
DO $$
DECLARE
    i INT := 1;
    random_start TIMESTAMP;
    random_end TIMESTAMP;
    random_name TEXT;
    random_capacity INT;
    session_names TEXT[] := ARRAY['Team Meeting', 'Conference Call', 'Training Session', 'Board Meeting', 'Project Review', 'Workshop', 'Webinar', 'Product Launch'];
BEGIN
    WHILE i <= 100 LOOP
        random_start := TIMESTAMP '2024-06-19 06:00:00' + (random() * (TIMESTAMP '2024-08-01 16:59:59' - TIMESTAMP '2024-06-19 06:00:00'));

        random_end := random_start + (random() * (TIMESTAMP '2024-08-01 17:00:00' - random_start));

        random_name := session_names[ceil(random() * array_length(session_names, 1))];

        random_capacity := 100 + floor(random() * 101);

        INSERT INTO sessions (session_name, start_time, end_time, max_capacity)
        VALUES (random_name, random_start, random_end, random_capacity);

        i := i + 1;
    END LOOP;
END $$;
