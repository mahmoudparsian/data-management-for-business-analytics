CREATE DATABASE Scholarship_Details;

USE Scholarship_Details;

CREATE TABLE Student_Details (
Student_ID INT primary key,
First_Name varchar(50),
Last_Name varchar(50),
Major varchar(50),
GPA decimal(5,2),
Enroll_Date datetime
);

INSERT INTO Student_Details ( Student_ID, First_Name, Last_Name, Major, GPA, Enroll_Date ) Values
(201, 'Shamsu', 'Zaman', 'CSE', 8.79, '2021-09-01 09:30:000'),
(202, 'Fahim', 'Islam', 'Math', 8.44, '2021-09-01 08:30:000'),
(203, 'Saif', 'Ali', 'Bio', 9.2, '2021-09-01 10:00:000'),
(204,'Rabiul', 'Islam', 'Che', 7.85, '2021-09-01 12:45:000'),
(205, 'Pranto', 'Khan', 'Phy', 9.56, '2021-09-01 08:30:000');

INSERT INTO Student_Details ( Student_ID, First_Name, Last_Name, Major, GPA, Enroll_Date ) Values
(206,'Nahid', 'Islam', 'his', 9.78, '2021-09-01 09:24:000'),
(207, 'Sakil', 'Hasan', 'Eng', 8.20, '2021-09-01 02:30:000'),
(208, 'Sayab', 'Zillu', 'Math', 7, '2021-09-01 06:30:000');


CREATE TABLE Student_Ref_Details (
Stud_Ref_ID INT,
Program_Name varchar (50),
Program_Start datetime 
);

Insert	into Student_Ref_Details Values
(201, 'CSE', '2021-09-01 00:00:000'),
(202, 'Math', '2021-09-01 00:00:000'),
(208, 'Math', '2021-09-01 00:00:000'),
(205, 'Phy', '2021-09-01 00:00:000'),
(204, 'Chem', '2021-09-01 00:00:000'),
(207, 'Psy', '2021-09-01 00:00:000'),
(206, 'His', '2021-09-01 00:00:000'),
(203, 'Bio', '2021-09-01 00:00:000');


create table Get_Scholarship (
student_ref_id int primary key,
scholarship_amount int,
scholarship_date datetime
);

insert into Get_Scholarship values
(201,5000,'2021-10-15 00:00:000'),
(202,4500,'2022-08-18 00:00:000'),
(203,3000,'2022-01-25 00:00:000'),
(204,4000, '2021-01-11 00:00:000');


SELECT * FROM Get_Scholarship;

SELECT * FROM student_details;

SELECT * FROM Student_ref_details;



ALTER TABLE student_ref_details
ADD CONSTRAINT fk_student_ref
FOREIGN KEY (Stud_Ref_ID) REFERENCES student_details(Student_ID);

ALTER TABLE get_scholarship
ADD CONSTRAINT fk_get_scholarship
FOREIGN KEY (student_ref_id) REFERENCES student_ref_details(Stud_Ref_ID);


SELECT s.First_Name, s.Last_Name, r.Program_Name, g.scholarship_amount
FROM student_details s
JOIN student_ref_details r ON s.Student_ID = r.Stud_Ref_ID
JOIN get_scholarship g ON r.Stud_Ref_ID = g.student_ref_id;



