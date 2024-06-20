/* WORKSPACES Script */
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
        room_id := (SELECT rooms_id FROM rooms OFFSET floor(random() * room_count) LIMIT 1);

        n_row := (SELECT floor(random() * num_rows) + 1 FROM rooms WHERE rooms_id = room_id);
        n_column := (SELECT floor(random() * num_columns) + 1 FROM rooms WHERE rooms_id = room_id);

        INSERT INTO workspaces (room_id, n_row, n_column) VALUES (room_id, n_row, n_column);
        i := i + 1;
    END LOOP;
END $$;