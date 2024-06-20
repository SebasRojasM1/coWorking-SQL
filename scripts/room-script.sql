/*SCRIPT Rooms*/
DO $$
DECLARE
    i INTEGER := 0;
    name_room VARCHAR(100);
    num_rows INTEGER;
    num_columns INTEGER;
BEGIN
    WHILE i < 100 LOOP
        name_room := 'Room ' || (i + 1);  
        num_rows := floor(random() * (25 - 5 + 1) + 5); 
        num_columns := floor(random() * (25 - 5 + 1) + 5);

        INSERT INTO rooms (name_room, num_rows, num_columns, created_at)
        VALUES (name_room, num_rows, num_columns, CURRENT_TIMESTAMP);

        i := i + 1;
    END LOOP;
END $$;