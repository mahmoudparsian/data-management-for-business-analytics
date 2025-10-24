-- ### `students`
INSERT INTO students VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Lee', 'charlie@example.com'),
(4, 'Diana Patel', 'diana@example.com'),
(5, 'Ethan Wright', 'ethan@example.com'),
(6, 'Fiona Chen', 'fiona@example.com'),
(7, 'George Kim', 'george@example.com'),
(8, 'Hannah Davis', 'hannah@example.com'),
(9, 'Ian Martinez', 'ian@example.com'),
(10, 'Julia Thompson', 'julia@example.com');



-- ### `dorms` (1-to-1 with students)
INSERT INTO dorms VALUES
(1, 'A101', 1),
(2, 'A102', 2),
(3, 'B201', 3),
(4, 'B202', 4),
(5, 'C301', 5),
(6, 'C302', 6),
(7, 'D401', 7),
(8, 'D402', 8),
(9, 'E501', 9),
(10, 'E502', 10);


-- ### `professors`
INSERT INTO professors VALUES
(1, 'Dr. Green', 'Mathematics'),
(2, 'Dr. Blue', 'Computer Science'),
(3, 'Dr. Red', 'Physics'),
(4, 'Dr. Yellow', 'Biology'),
(5, 'Dr. Purple', 'History');


-- ### `courses` (1-to-Many with professors)
INSERT INTO courses VALUES
(1, 'Calculus I', 1),
(2, 'Linear Algebra', 1),
(3, 'Intro to Programming', 2),
(4, 'Data Structures', 2),
(5, 'Quantum Mechanics', 3),
(6, 'Classical Mechanics', 3),
(7, 'Genetics', 4),
(8, 'Cell Biology', 4),
(9, 'World History', 5),
(10, 'Modern History', 5);


-- ### `enrollments` (M-to-M between students and courses)
INSERT INTO enrollments VALUES
(1, 1), 
(1, 3), 
(1, 5),
(2, 2), 
(2, 3), 
(2, 4),
(3, 1), 
(3, 6), 
(3, 7),
(4, 4), 
(4, 8), 
(4, 9),
(5, 2), 
(5, 5), 
(5, 10),
(6, 3), 
(6, 6), 
(6, 7),
(7, 1), 
(7, 4), 
(7, 9),
(8, 2), 
(8, 8), 
(8, 10),
(9, 3), 
(9, 5), 
(9, 6),
(10, 1), 
(10, 7), 
(10, 9);

