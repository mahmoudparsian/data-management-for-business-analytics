## SCHOOL DATABASE

### PROJECT DESCRIPTION
This database schema organizes a schooll workflow into tables where they are constrained to foreign keys to link the tables together characterized by 5th normal form.

### Tools
- MySQL workbench

### creating database

```sql
create database school;
#drop database school;
use school;
```

### creating tables

```sql
create table students(
RegNo varchar(10) primary key NOT NULL,
F_name char(10),
L_name char(10),
reg_year int,
stream_id int,
gender char(10)
);
 
create table streams(
stream_id int PRIMARY KEY NOT NULL,
stream_name varchar(10), 
class_teacher varchar(20),
head varchar(20),
foreign key(head) references students(RegNo) on delete set null
);
```

### Alter table students to add foreign key pointing to streams

```sql
ALTER table students
add foreign key(stream_id)
 references streams(stream_id) on delete set null;
```

### Adding more tables

```sql
create table teaching_staff(
T_id varchar(20) primary key not null,
F_name char(20),
L_name char(20),
emp_type varchar(20),
salary int,
department varchar(20),
Gender char(10)
);
```
### Alter table streams to add foreign key pointing to teaching staff

```sql
ALTER table streams
add foreign key(class_teacher)
 references teaching_staff(T_id) on delete set null;
```
### Adding more tables

```sql
create table Non_staff(
staff_id varchar(20) primary key not null,
F_name char(20),
L_name char(20),
Roles varchar(20),
salary int,
emp_date date,
Gender char(20)
);


create table Department(
depart_id varchar(20) primary key not null,
depart_name char(20)
);
```

### Alter table teaching staff to add foreign key pointing to department

```sql
ALTER table teaching_staff
add foreign key(department)
 references department(depart_id) on delete set null;
```

### Adding more tables to dtabase schema

```sql
create table student_leaders(
RegNo varchar(10) primary key NOT NULL,
year_ int,
Roles varchar(20),
stream_id int,
foreign key(RegNo) references students(RegNo) on delete cascade,
foreign key(stream_id) references streams(stream_id) on delete set null
);

create table subjects(
sub_code varchar(10) primary key NOT NULL,
sub_name varchar(10),
Depart varchar(20),
foreign key(Depart) references Department(depart_id) on delete set null
);
```

### Inserting values to our tables

```sql
insert into department
 values(201,"languages"),
       (202,"science"),
       (203,"Humanities"),
       (204,"Technical");

insert into subjects
 values(101,"English",201),
       (102,"Literature",201),
       (103,"kiswahili",201),
       (104,"Maths",202),
       (105,"Chemistry",202),
       (106,"Physics",202),
       (107,"Computer",202),
       (108,"Geography",203),
       (109,"C.R.E",203),
       (110,"History",203),
       (111,"B/Studies",204),
       (112,"Agri",204);
       
insert into non_staff
 values(1001,"Alice","maina","cleaner",20000,"2009-12-20","F"),
       (1002,"lois","juma","cleaner",22000,"2002-11-24","F"),
       (1003,"mike","mwendwa","cleaner",17000,"2019-12-20","M"),
       (1004,"christine","maina","cook",25000,"2010-12-02","F"),
       (1005,"Dan","kbet","cook",20000,"2022-12-20","M"),
       (1006,"Daniel","Koech","cook",28000,"2006-10-29","M"),
       (1007,"judith","maina","secretary",30000,"2009-06-20","F"),
       (1008,"frankline","kirui","Bursar",40000,"2014-11-10","M"),
       (1009,"Alice","juma","Librarian",30000,"2009-12-20","F"),
       (1010,"victor","koros","store keeper",34000,"2023-03-20","M");
insert into teaching_staff
 values(501,"Alice","maina","G_employee",Null,201,"F"),(502,"collins","kirui","G_employee",Null,201,"M"),
       (503,"Rose","cherotich","B.O.M",35000,202,"F"),(504,"Alice","maina","G_employee",Null,201,"F"),
       (505,"Dancan","kirui","P.T.A",20000,202,"M"),(506,"Daniel","Koech","B.O.M",28000,203,"M"),
       (507,"judith","kerubo","G_employee",Null,204,"F"),(508,"frankline","kirui","G_employee",Null,204,"M"),
       (509,"Alice","Maina","B.O.M",34000,203,"F"),(510,"Tom","koros","B.O.M",35000,204,"M"),
       (511,"Rose","maina","G_employee",Null,204,"F"),(512,"Mike","kirui","B.O.M",30500,201,"M"),
       (513,"Jeff","koskei","B.O.M",35000,202,"M"),(514,"Tom","Isaac","G_employee",Null,201,"M"),
       (515,"Newton","Alonso","P.T.A",28000,203,"M"),(516,"Antony","Martial","B.O.M",38000,204,"M"),
       (517,"Edna","kerubo","G_employee",Null,204,"F"),(518,"Mark","Onyango","B.O.M",34000,201,"M"),
       (519,"Bruno","Fernandes","P.T.A",25000,203,"M"),(520,"Ann","machoka","P.T.A",35000,202,"F");
# Every class has 4 streams named north,east,south,west
insert into streams
values(1,"1N",501,Null),(2,"1E",503,Null),(3,"1S",505,Null),(4,"1w",507,Null),
      (5,"2N",509,Null),(6,"2E",511,Null),(7,"2S",513,Null),(8,"2w",515,Null),
      (9,"3N",517,Null),(10,"3E",519,Null),(11,"3S",502,Null),(12,"3w",504,Null),
      (13,"4N",506,Null),(14,"4E",508,Null),(15,"4S",510,Null),(16,"4w",512,Null);
      
insert into students 
values (2000,"collins","kipkirui",2021,13,"M"),(2001,"shadrack","kirui",2021,13,"M"),(2003,"Tabitha","koech",2021,13,"F"),
       (2004,"collins","Ngeno",2021,14,"M"),(2005,"sharon","chepkirui",2021,14,"F"),(2006,"Marrion","koech",2021,14,"F"),
       (2007,"Peter","Rono",2021,15,"M"),(2008,"shadrack","omollo",2021,15,"M"),(2009,"Daisy","Maina",2021,15,"F"),
       (2010,"Tom","Munyau",2021,16,"M"),(2011,"sharon","Mwaura",2021,16,"F"),(2012,"Robart","koech",2021,16,"M"),
       (2013,"calep","kipkirui",2022,9,"M"),(2014,"shadrack","kirui",2022,9,"M"),(2015,"Doreen","koech",2022,9,"F"),
       (2016,"clark","Son",2022,10,"F"),(2017,"sharon","chepkirui",2022,10,"F"),(2018,"Mallon","koech",2022,10,"M"),
       (2019,"collins","maina",2022,11,"M"),(2020,"shad","kirui",2022,11,"M"),(2021,"Taby","koech",2022,11,"F"),
       (2022,"kips","Ngeno",2022,12,"M"),(2023,"sharon","chepkirui",2022,12,"F"),(2024,"Marrion","mwaura",2023,12,"F"),
       (2025,"collins","kipkirui",2023,5,"M"),(2026,"shadrack","kirui",2023,5,"M"),(2027,"Tabitha","koech",2023,5,"F"),
       (2028,"collins","Ngeno",2023,6,"M"),(2029,"sharon","chepkirui",2023,6,"F"),(2030,"Marrion","koech",2023,6,"F"),
       (2031,"simon","kirui",2023,7,"M"),(2032,"Jerry","Simon",2023,7,"M"),(2033,"Betty","Khasoa",2023,7,"F"),
       (2034,"Joakim","Morris",2023,8,"M"),(2035,"Getrude","chepkirui",2023,8,"F"),(2036,"Laureen","odhiambo",2023,8,"F"),
       (2037,"Vincent","kibet",2024,1,"M"),(2038,"vincent","odhiambo",2024,1,"M"),(2039,"vallary","vuguza",2024,1,"F"),
       (2040,"Ben","Ogendo",2024,2,"M"),(2041,"jacky","Mgeni",2024,2,"F"),(2042,"odero","omondi",2024,2,"M"),
       (2043,"Brian","Onsoro",2024,3,"M"),(2044,"Emmanuel","Nyongeza",2024,3,"M"),(2045,"gift","koech",2024,3,"F"),
       (2046,"Felix","Oyuki",2024,4,"M"),(2047,"irine","Nyongeza",2024,4,"F"),(2048,"Marrion","koech",2024,4,"F");
```
### updating the streams values which had innitially null values 
- we could not insert stream head values to our table because it is pointing to students table which had no values inserted yet. we set it to null to enable us insert values to all the columns. After inserting values to students table, then we can update the streams table.

 ```sql
update streams
set head=2039
where stream_id=1;

update streams
set head=2045
where stream_id=3;

update streams
set head=2048
where stream_id=4;

update streams
set head=2025
where stream_id=5;

update streams
set head=2030
where stream_id=6;

update streams
set head=2031
where stream_id=7;

update streams
set head=2034
where stream_id=8;

update streams
set head=2013
where stream_id=9;

select * from students 
order  by stream_id;

update streams
set head=2041
where stream_id=2;

update streams
set head=2018
where stream_id=10;

update streams
set head=2021
where stream_id=11;

update streams
set head=2022
where stream_id=12;

update streams
set head=2001
where stream_id=13;

update streams
set head=2004
where stream_id=14;

update streams
set head=2007
where stream_id=15;

update streams
set head=2012
where stream_id=16;
```
### Inserting values to other tables

```sql
insert into student_leaders
 values(2012,2024,"class_prefect",16),(2007,2024,"class_prefect",15),(2004,2024,"class_prefect",14),
       (2001,2024,"class_prefect",13),(2022,2024,"class_prefect",12),(2021,2024,"class_prefect",11),
       (2018,2024,"class_prefect",10),(2013,2024,"class_prefect",9),(2034,2024,"class_prefect",8),
       (2031,2024,"class_prefect",7),(2030,2024,"class_prefect",6),(2025,2024,"class_prefect",5),
       (2048,2024,"class_prefect",4),(2039,2024,"class_prefect",1),(2045,2024,"class_prefect",3),
       (2041,2024,"class_prefect",2),(2010,2024,"Captain",16),(2019,2024,"Games_captain",11),
       (2008,2024,"Entertainment",15),(2006,2024,"Dinning_hall",14),(2000,2024,"Student_affairs",13),
       (2023,2024,"Dormitories",12);
```

## WORKING WITH SQL QUERIES
### Aggregate fuctions

```sql
  -- count the number of students and group them as male or female 
 select count(gender), gender
 from students
 group by gender;

  -- find the avg salary teaching_staff
  
  select avg(salary) from teaching_staff;

-- find the sum of salaries of Non teaching staff
  
  select sum(salary) from non_staff;

  -- find the oldest employee in non teaching staff
  
  select min(emp_date) from non_staff;

select count(gender), gender
from students
group by gender;
 
 select sum(salary), gender
 from teaching_staff
 group by gender;
 

```

 ### WILDCARDS

 ```SQL
 -- find all students who their names begin with "v"

  select * from students
  where F_name like "v%";

   -- find all students who their names ends with "o"

   select * from students
  where l_name like "%o";

   select * from students
   where F_name like "v______%";

  -- fill non staff who were born in december

  select * from non_staff
  where emp_date like "____-12-__";
```
### WORKING WITH JOINS 

```sql
select streams.stream_name, teaching_staff.F_name, teaching_staff.L_name
from streams
left join teaching_staff
on class_teacher=T_id;

select streams.stream_name, teaching_staff.F_name, teaching_staff.L_name
from streams
right join teaching_staff
on class_teacher=T_id;

select streams.stream_name, students.F_name, students.L_name
from streams
 join students
on streams.head=students.RegNo;

select student_leaders.roles, students.F_name, students.L_name
from student_leaders
join students
on student_leaders.RegNo=students.RegNo
where Roles="class_prefect";

 select teaching_staff.F_name,teaching_staff.L_name,department.depart_name
 from teaching_staff
 join department
 on teaching_staff.department=department.depart_id
 where depart_name="languages";

-- Returning f_name and L_name  as full name 
 select concat(f_name,"   ",l_name) as "staff name",department.depart_name,teaching_staff.Gender
 from teaching_staff
 join department
 on teaching_staff.department=department.depart_id;
```
### JOINING TWO OR MORE TABLES USING PARENT TABLE to child

```sql
select streams.stream_name,students.RegNo,students.F_name as class_prefect,students.L_name as "",teaching_staff.F_name as class_teacher,teaching_staff.L_name as ""
from students,streams,teaching_staff
where students.RegNo=streams.head and
      streams.class_teacher=teaching_staff.T_id;


 select teaching_staff.F_name,teaching_staff.L_name,department.depart_name
 from teaching_staff, department
 where teaching_staff.department=department.depart_id and
       department.depart_name="science";
```
###  JOINING TWO OR MORE TABLES USING INNER JOIN

```sql
select streams.stream_name,students.RegNo,students.F_name as class_prefect,students.L_name as "",teaching_staff.F_name as class_teacher,teaching_staff.L_name as ""
from students
inner join streams
on students.RegNo=streams.head
inner join teaching_staff
on streams.class_teacher=teaching_staff.T_id;

```
### INCREASE SALARY OF ALL NON TEACHING STAFF BY 5%
 
 ```sql
 UPDATE non_staff set salary=salary+(salary*5/100);
```

 ### selecting all non staff whose salary lies from 20,000 to 40,000
 
 ```sql
select * from non_staff
where salary between 20000 and 40000;
```
 ## sub Queries
### scalar sub query
 - it always returns one row and one column

### QUIZ: FIND the teaching_staff whos salary is mpore than avg salary earned by all staff
 1. find the avg salary
 2. filter the employees based on the above result

 ```sql 
 
 select avg(salary) from teaching_staff; -- 31458.3333
 
 select * from teaching_staff -- outer query/ main query
 where salary > ( select avg(salary) from teaching_staff); -- sub query/ inner query
 ```


 ### multiple row sub query
 ```sql
-- sub query returns  multiple columns and maltiple rows
 -- sub query returns only 1 column and multiple rows
/* QUIZ: find te teaching_staff who earn the highest salary in each department */

select department.depart_name,  max(salary)
from teaching_staff, department
where department.depart_id=teaching_staff.department
group by department.depart_name;

select concat(F_name,"  ",L_name) as " Staff Name", emp_type, depart_name, salary, Gender
from department, teaching_staff
where(depart_name,salary) in (select department.depart_name,  max(salary)
                              from teaching_staff, department
                              where department.depart_id=teaching_staff.department
                              group by department.depart_name)
                              order by depart_name desc;
```


