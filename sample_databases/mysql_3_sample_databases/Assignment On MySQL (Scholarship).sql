CREATE DATABASE Student_Scholarship;

USE Student_Scholarship;

CREATE TABLE Student (
Student_ID INT primary key,
First_Name varchar(50),
Last_Name varchar(50),
Major varchar(50),
GPA decimal(5,2),
Enroll_Date datetime
);

INSERT INTO Student ( Student_ID, First_Name, Last_Name, Major, GPA, Enroll_Date ) Values
(201, 'Shivansh', 'Mahajan' , 'CSE', 8.79, '2021-09-01 09:30:000'),
(202, 'Umesh', 'Sharma', 'Math', 8.44, '2021-09-01 08:30:000'),
(203, 'Rakesh', 'Kumar', 'Bio', 9.2, '2021-09-01 10:00:000'),
(204,'Radha', 'Sharma', 'Che', 7.85, '2021-09-01 12:45:000'),
(205, 'Kush', 'Kumar', 'Phy', 9.56, '2021-09-01 08:30:000');

INSERT INTO Student ( Student_ID, First_Name, Last_Name, Major, GPA, Enroll_Date ) Values
(206,'Prem', 'Chopra', 'his', 9.78, '2021-09-01 09:24:000'),
(207, 'Pankaj', 'Vats', 'Eng', 8.20, '2021-09-01 02:30:000'),
(208, 'Navleen', 'Kaur', 'Math', 7, '2021-09-01 06:30:000');


CREATE TABLE Program (
Stud_Ref_ID INT,
Program_Name varchar (50),
Program_Start datetime 
);

Insert	into Program Values
(201, 'CSE', '2021-09-01 00:00:000'),
(202, 'Math', '2021-09-01 00:00:000'),
(208, 'Math', '2021-09-01 00:00:000'),
(205, 'Phy', '2021-09-01 00:00:000'),
(204, 'Chem', '2021-09-01 00:00:000'),
(207, 'Psy', '2021-09-01 00:00:000'),
(206, 'His', '2021-09-01 00:00:000'),
(203, 'Bio', '2021-09-01 00:00:000');


create table Scholarship (
student_ref_id int primary key,
scholarship_amount int,
scholarship_date datetime
);

insert into Scholarship values
(201,5000,'2021-10-15 00:00:000'),
(202,4500,'2022-08-18 00:00:000'),
(203,3000,'2022-01-25 00:00:000'),
(204,4000, '2021-01-11 00:00:000');


SELECT * FROM Scholarship;

SELECT * FROM student;

SELECT * FROM Program;





#Answer The Question No. 01
SELECT upper(FIRST_NAME) as STUDENT_NAME From Student;


#Answer The Question No. 02
SELECT DISTINCT Major FROM Student;
SELECT Major FROM Student GROUP BY (Major);


#Answer The Question No. 03
SELECT SUBSTRING(First_Name, 1,3) FROM Student;


#Answer The Question No. 04
SELECT INSTR(LOWER(First_Name), 'a') FROM Student WHERE First_Name='Shivansh';


#Answer The Question No. 05
SELECT DISTINCT Major, LENGTH(Major) FROM Student;


#Answer The Question No. 06
SELECT REPLACE(First_Name,'a','A') FROM Student;


#Answer The Question No. 07
SELECT CONCAT(First_Name,' ',Last_Name)AS Complete_Name FROM Student;


#Answer The Question No. 08
SELECT * FROM Student ORDER BY First_Name, Major DESC;


#Answer The Question No. 09
SELECT * FROM Student WHERE First_Name IN ('Prem','Shivansh');


#Answer The Question No. 10
SELECT * FROM Student WHERE First_Name NOT IN ('Prem','Shivansh');


#Answer The Question No. 11
SELECT * FROM Student WHERE First_Name LIKE '%a';


#Answer The Question No. 12
SELECT * FROM Student WHERE First_Name LIKE '____a';


#Answer The Question No. 13
SELECT * FROM Student WHERE GPA BETWEEN 9.00 AND 9.99;


#Answer The Question No. 14
SELECT Major,COUNT(*) AS TOTAL_COUNT FROM Student WHERE Major='CSE';


#Answer The Question No. 15
SELECT CONCAT(First_Name,' ',Last_Name) AS Full_Name FROM Student WHERE GPA BETWEEN 8.5 and 9.5;


#Answer The Question No. 16
SELECT Major, COUNT(Major) FROM Student GROUP BY Major ORDER BY COUNT(Major) DESC;


#Answer The Question No. 17
SELECT
      Student.First_Name,
      Student.Last_Name,
      Scholarship.Scholarship_Amount,
	  Scholarship.Scholarship_Date
FROM 
      Student
INNER JOIN Scholarship ON Student.Student_ID = Scholarship.Student_Ref_ID;


#Answer The Question No. 18
SELECT * FROM Student WHERE Student_ID %2=1;


#Answer The Question No. 19
SELECT * FROM Student WHERE Student_ID %2=0;


#Answer The Question No. 20
SELECT Student.First_Name, Student.Last_Name,
Scholarship.Scholarship_Amount,
Scholarship.Scholarship_Date FROM Student LEFT JOIN
Scholarship ON Student.Student_ID=
Scholarship.Student_Ref_ID;


#Answer The Question No. 21
SELECT * FROM Student ORDER BY GPA DESC LIMIT 5;


#Answer The Question No. 22
SELECT * FROM Student ORDER BY GPA DESC LIMIT 4,1;


#Answer The Question No. 23
SELECT * FROM Student S1
WHERE 4=
   (SELECT COUNT(DISTINCT(S2.GPA))
   FROM Student S2 
   WHERE S2.GPA >=S1.GPA
);


#Answer The Question No. 24
SELECT S1.* FROM Student S1, Student S2 WHERE S1.GPA AND S1.Student_ID !=S2.Student_ID;


#Answer The Question No. 25
SELECT MAX(GPA) FROM Student
WHERE GPA NOT IN(SELECT MAX(GPA) FROM Student);


#Answer The Question No. 26
SELECT * FROM Student
UNION ALL
SELECT * FROM Student ORDER BY Student_ID;


#Answer The Question No. 27
SELECT Student_ID FROM Student 
WHERE Student_ID NOT IN (SELECT Student_Ref_ID FROM Scholarship);


#Answer The Question No. 28
SELECT * FROM Student
LIMIT(SELECT FLOOR(COUNT(*)/2) FROM Student);


#Answer The Question No. 29
SELECT Major, COUNT(Major) AS Major_Count FROM Student GROUP BY Major HAVING COUNT(Major)<4;


#Answer The Question No. 30
SELECT Major, COUNT(Major) AS ALL_Major FROM Student GROUP BY Major;


#Answer The Question No. 31
SELECT * FROM Student WHERE Student_ID = (SELECT MAX(Student_ID) FROM Student);


#Answer The Question No. 32
SELECT * FROM Student WHERE Student_ID = (SELECT MIN(Student_ID) FROM Student);


#Answer The Question No. 33
SELECT *
FROM(
   SELECT *
   FROM Student
   ORDER BY Student_ID DESC
   LIMIT 5)
AS Subquery
ORDER BY Student_ID;


#Answer The Question No. 34
SELECT DISTINCT GPA FROM Student S1
WHERE 3>=(SELECT COUNT(DISTINCT GPA) FROM Student S2 WHERE S1.GPA <= S2.GPA)
ORDER BY S1.GPA DESC;


#Answer The Question No. 35
SELECT DISTINCT GPA FROM Student S1
WHERE 3>= (SELECT COUNT(DISTINCT GPA) FROM Student S2 WHERE S1.GPA>=S2.GPA)
ORDER BY S1.GPA;


#Answer The Question No. 36
SELECT DISTINCT GPA FROM Student S1
WHERE 2=(SELECT COUNT(DISTINCT GPA) FROM Student S2 WHERE S1.GPA <= S2.GPA)
ORDER BY S1.GPA DESC;


#Answer The Question No. 37
SELECT Major, MAX(GPA) AS MaxGPA FROM Student GROUP BY Major;


#Answer The Question No. 38
SELECT First_Name, GPA FROM Student WHERE GPA=(SELECT MAX(GPA) FROM Student);


#Answer The Question No. 39
SELECT CURDATE();
SELECT NOW();


#Answer The Question No. 40
CREATE TABLE CloneTable As SELECT * FROM Student;


#Answer The Question No. 41
UPDATE Student SET GPA = 7.5 WHERE Major= 'CSE';


#Answer The Question No. 42
SELECT Major, AVG(GPA) AS Average_GPA FROM Student GROUP BY Major;


#Answer The Question No. 43
SELECT * FROM Student ORDER BY GPA DESC LIMIT 3;


#Answer The Question No. 44
SELECT Major, COUNT(Student_ID) AS High_GPA_COUNT FROM Student
WHERE GPA>7.5
GROUP BY Major;


#Answer The Question No. 45
SELECT * FROM Student WHERE GPA=(SELECT GPA FROM Student WHERE Student_ID=201);