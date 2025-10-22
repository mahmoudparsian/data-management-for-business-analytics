-- Fast import (adjust path as needed; requires FILE privilege)
LOAD DATA INFILE '/absolute/path/students.csv'
INTO TABLE students
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(student_id,name,major,country);

LOAD DATA INFILE '/absolute/path/courses.csv'
INTO TABLE courses
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(course_id,course_name,instructor);

LOAD DATA INFILE '/absolute/path/enrollments.csv'
INTO TABLE enrollments
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(student_id,course_id);
