/*=====================Falculty table===================*/
CREATE TABLE Faculty
(
    faculty_id char(2) PRIMARY KEY,
    faculty_name nvarchar(30) NOT NULL
);
/*=====================Student table===================*/
DROP TABLE Student;
CREATE TABLE Student
(
student_id char(3) NOT NULL PRIMARY KEY,
firstname nvarchar(30) NOT NULL ,
lastname nvarchar(30) NOT NULL ,
gender enum('male', 'female' , 'homo'),
date_of_birth date NOT NULL ,
country_of_bird nvarchar(20),
faculty_id char(2),
scholarship_id char(3)
);
/*=====================Subject table===================*/
CREATE TABLE Subject
(
subject_id char(3) NOT NULL PRIMARY KEY,
subject_name nvarchar(25) NOT NULL ,
prerequisite nvarchar(30) DEFAULT NULL,
requirement nvarchar(30) DEFAULT NULL,
credit decimal(3,1) /* 3 digits in total, 1 digit after the comma */
);
/*===================== Result table===================*/
CREATE TABLE Result
(
student_id char(3) NOT NULL,
subject_id char(3) NOT NULL,
attempt int DEFAULT 1,
score int,
PRIMARY KEY (student_id, subject_id, attempt)
);
/*===================== Enrolment table===================*/
CREATE TABLE Enrolment
(
enrolment_id char(3) NOT NULL PRIMARY KEY,
student_id char(3) NOT NULL,
class_id char(3),
title nvarchar(30)
);
/*===================== Class table===================*/
CREATE TABLE Class
(
class_id char(3) NOT NULL PRIMARY KEY,
convener_id char(3) NOT NULL,
subject_id char(3) NOT NULL,
title nvarchar(30)
);
/*===================== Class table===================*/
CREATE TABLE Room_Class
(
room_id char(3),
class_id char(3),
note nvarchar(30)
);
/*===================== Room table===================*/
CREATE TABLE Room
(
room_id char(3) NOT NULL PRIMARY KEY,
number_of_seat int NOT NULL,
reserve bool DEFAULT False
);
/*===================== Tutor table===================*/
CREATE TABLE Tutor
(
tutor_id char(3) NOT NULL PRIMARY KEY,
rank char(3),
tutor_name nvarchar(30) NOT NULL,
tutor_dob date NOT NULL,
tutor_desc nvarchar(30)
);
/*===================== Tutor_Class table===================*/
CREATE TABLE Tutor_Class 
(
class_id char(3) NOT NULL,
tutor_id char(3) NOT NULL,
note nvarchar(30)
);
/*===================== Convener table===================*/
CREATE TABLE Convener
(
convener_id char(3) NOT NULL PRIMARY KEY,
rank char(3),
convener_name nvarchar(30),
convener_dob date
);
/*===================== Faculty_Convener table===================*/
CREATE TABLE Faculty_Convener
(
convener_id char(3) NOT NULL,
faculty_id char(2) NOT NULL
); 
/*===================== Salary table===================*/
CREATE TABLE Salary
(
rank CHAR(3) NOT NULL PRIMARY KEY,
pay_rate decimal(6,3),
further_detail nvarchar(30)
);
/*===================== Scholarship table===================*/
CREATE TABLE Scholarship
(
scholarship_id char(3) NOT NULL PRIMARY KEY,
scholarship_value int(6) NOT NULL,
scholarship_condition nvarchar(30),
scholarship_desc nvarchar(30)
);
/*===================== Provider table===================*/
CREATE TABLE Provider 
(
provider_id CHAR(3) PRIMARY KEY,
provider_name nvarchar(30) NOT NULL,
provider_business_no INT(6) NOT NULL
);
/*===================== Scholarship_Provider table===================*/
CREATE TABLE Scholarship_Provider
(
scholarship_id char(3) NOT NULL,
provider_id char(3) NOT NULL,
note nvarchar(30)
);
/*===================== Foreign Key===================*/
/*==========Student=========*/
ALTER TABLE Student 
ADD CONSTRAINT fk_Student_Faculty
FOREIGN KEY (faculty_id) REFERENCES Faculty (faculty_id);

ALTER TABLE Student 
ADD CONSTRAINT fk_Student_Scholarship
FOREIGN KEY (scholarship_id) REFERENCES Scholarship (scholarship_id);
/*=========Result===========*/
ALTER TABLE Result 
ADD CONSTRAINT fk_Result_Student
FOREIGN KEY (student_id) REFERENCES Student (student_id);

ALTER TABLE Result 
ADD CONSTRAINT fk_Result_Subject
FOREIGN KEY (subject_id) REFERENCES Subject (subject_id);
/*=========Enrolment========*/
ALTER TABLE Enrolment
ADD CONSTRAINT fk_Enrolment_Student
FOREIGN KEY (student_id) REFERENCES Student (student_id);

ALTER TABLE Enrolment
ADD CONSTRAINT fk_Enrolment_Class
FOREIGN KEY (class_id) REFERENCES Class (class_id);
/*=========Scholarship_Provider======*/
ALTER TABLE Scholarship_Provider
ADD CONSTRAINT fk_Scholarship_Provider
FOREIGN KEY (scholarship_id) REFERENCES Scholarship (scholarship_id);

ALTER TABLE Scholarship_Provider
ADD CONSTRAINT fk_Provider_Scholarship
FOREIGN KEY (provider_id) REFERENCES Provider (provider_id);
/*==========Class==========*/
ALTER TABLE Class
ADD CONSTRAINT fk_Class_Convener
FOREIGN KEY (convener_id) REFERENCES Convener (convener_id);

ALTER TABLE Class
ADD CONSTRAINT fk_Class_Subject
FOREIGN KEY (subject_id) REFERENCES Subject (subject_id);
/*===========Room_class===========*/
ALTER TABLE Room_Class
ADD CONSTRAINT fk_Room_Class
FOREIGN KEY (room_id) REFERENCES Room (room_id);

ALTER TABLE Room_Class
ADD CONSTRAINT fk_Class_Room
FOREIGN KEY (class_id) REFERENCES Class (class_id);
/*============Convener============*/
ALTER TABLE Convener
ADD CONSTRAINT fk_Convener_Salary
FOREIGN KEY (rank) REFERENCES Salary (rank);
/*=============Tutor_Class==========*/
ALTER TABLE Tutor_Class
ADD CONSTRAINT fk_Tutor_Class
FOREIGN KEY (tutor_id) REFERENCES Tutor (tutor_id);

ALTER TABLE Tutor_Class
ADD CONSTRAINT fk_Class_Tutor
FOREIGN KEY (class_id) REFERENCES Class (class_id);
/*===============Tutor==============*/
ALTER TABLE Tutor
ADD CONSTRAINT fk_Tutor_Salary
FOREIGN KEY (rank) REFERENCES Salary (rank);
/*================Faculty_Convener==============*/
ALTER TABLE Faculty_Convener
ADD CONSTRAINT fk_Faculty_Convener
FOREIGN KEY (faculty_id) REFERENCES Faculty (faculty_id);

ALTER TABLE Faculty_Convener
ADD CONSTRAINT fk_Convener_Faculty
FOREIGN KEY (convener_id) REFERENCES Convener (convener_id);


/* 5. Main usage and Scripts for typical use cases */

/*=====================Test Data===================*/
/*==============Test data Subject =============*/
INSERT INTO Subject (subject_id, subject_name , credit)
VALUES ('A01', 'database system',45);
INSERT INTO Subject (subject_id, subject_name , credit)
VALUES ('B02', 'artificial intelligent',45);
INSERT INTO Subject (subject_id, subject_name , credit)
VALUES ('C03', 'programming',45);
INSERT INTO Subject (subject_id, subject_name , credit)
VALUES ('D04', 'graphical design',60);
INSERT INTO Subject (subject_id, subject_name , credit)
VALUES ('E05', 'biology',60);

SELECT * FROM Subject;
/*==============Test data Faculty =============*/
INSERT INTO Faculty ( faculty_id , faculty_name)
VALUES ('AV', 'Engineering');
INSERT INTO Faculty ( faculty_id , faculty_name)
VALUES ('TH', 'Information Technology');
INSERT INTO Faculty ( faculty_id , faculty_name)
VALUES ('TR', 'Phylosophy');
INSERT INTO Faculty ( faculty_id , faculty_name)
VALUES ('VL', 'Physic');

SELECT * FROM Faculty;
/*==============Test data Scholarship=========*/
INSERT INTO Scholarship( scholarship_id, scholarship_value, scholarship_condition)
VALUES (130, 100000, 'no fail unit');
INSERT INTO Scholarship( scholarship_id, scholarship_value, scholarship_condition)
VALUES (150, 200000, 'at least pass all');
INSERT INTO Scholarship( scholarship_id, scholarship_value, scholarship_condition)
VALUES (170, 300000, 'HD on every unit');
/*==============Test data Student=============*/

INSERT INTO Student( student_id , firstname , lastname , gender , date_of_birth , country_of_bird, faculty_id ,scholarship_id)
VALUES ('A01', 'Andrew', 'Ng', 'female' ,'1994/12/12', 'Melbourne','TH',130);
INSERT INTO Student( student_id , firstname , lastname , gender , date_of_birth , country_of_bird, faculty_id ,scholarship_id)
VALUES ('A02', 'Geoff', 'Hinton', 'male','1994/06/22', 'Sydney','VL',150);
INSERT INTO Student( student_id , firstname , lastname , gender , date_of_birth , country_of_bird, faculty_id ,scholarship_id)
VALUES ('A03', 'Joshen', 'Joe', 'female','1995/03/24', 'Canberra','TH',170);
INSERT INTO Student( student_id , firstname , lastname , gender , date_of_birth , country_of_bird, faculty_id)
VALUES ('A04', 'Palo', 'Kai', 'male','1994/03/14', 'Melbourne','AV');
INSERT INTO Student( student_id , firstname , lastname , gender , date_of_birth , country_of_bird, faculty_id)
VALUES ('B01', 'Kaio', 'Sing', 'female','1994/11/01', 'Melbourne','TR');
INSERT INTO Student( student_id , firstname , lastname , gender , date_of_birth , country_of_bird, faculty_id)
VALUES ('B02', 'andrew', 'a', 'female','1994/01/22', 'Melbourne','AV');

SELECT * FROM Student;
/*====================Test data Result==================*/

INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A01','A01',1,3);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A01','A01',2,6);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A01','B02',2,6);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A01','C03',1,5);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A02','A01',1,4.5);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A02','A01',2,7);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A02','C03',1,10);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A02','E05',1,9);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A03','A01',1,2);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A03','A01',2,5);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A03','C03',1,2.5);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A03','C03',2,4);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('A04','E05',2,10);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('B01','A01',1,7);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('B01','C03',1,2.5);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('B01','C03',2,5);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('B02','B02',1,6);
INSERT INTO Result (student_id,subject_id,attempt,score)
VALUES ('B02','D04',1,10);

SELECT * FROM Result;
/*====================Test data Provider==================*/
INSERT INTO Provider (provider_id, provider_name, provider_business_no)
VALUES ('P01', 'government', 111221);
INSERT INTO Provider (provider_id, provider_name, provider_business_no)
VALUES ('P02', 'monash provider', 412321);
INSERT INTO Provider (provider_id, provider_name, provider_business_no)
VALUES ('P03', 'swinburne provider', 221921);
INSERT INTO Provider (provider_id, provider_name, provider_business_no)
VALUES ('P04', 'Latrobe Uni provider', 114223);

SELECT * FROM Provider;
/*=====================Test data Scholarship_Provider*/
INSERT INTO Scholarship_Provider (scholarship_id, provider_id)
VALUES (130, 'P01');
INSERT INTO Scholarship_Provider (scholarship_id, provider_id)
VALUES (150, 'P03');
INSERT INTO Scholarship_Provider (scholarship_id, provider_id)
VALUES (150, 'P03');
