# MySQL Instructor/Students Package

Consider the following two tables in MySQL:

CREATE TABLE cats (
        id INT PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        date_of_birth DATE,
        num_of_tricks INT,
        country VARCHAR(20),
        gender VARCHAR(10),
        breed varchar(20),
        age INT
);

CREATE TABLE breeds (
        breed varchar(20) PRIMARY KEY,
        description VARCHAR(128)
);

Use the following data (copied from chatGPT) for the breeds table
(using SQL INSERT).

	•	Persian – long-haired, calm, affectionate
	•	Maine Coon – large, friendly, sociable “gentle giant”
	•	Siamese – vocal, slender, striking blue eyes
	•	Bengal – spotted/rosetted coat, active, wild appearance
	•	Sphynx – hairless, affectionate, unique look
	•	Ragdoll – relaxed, cuddly, blue-eyed
	•	British Shorthair – round face, plush coat, calm
	•	Scottish Fold – folded ears, sweet temperament
	•	Abyssinian – sleek, ticked coat, very active
	•	Oriental Shorthair – diverse colors/patterns, slender build
	•	Russian Blue – short blue-gray coat, bright green eyes
	•	Norwegian Forest Cat – thick fur, strong climber
	•	American Shorthair – adaptable, easygoing
	•	Exotic Shorthair – similar to Persian, but with short coat
	•	Turkish Angora – elegant, silky coat, playful

1. we want to create 120 cats by CSV and SQL INSERT.
I want the names of cats to be as real as possible,
no name_1, name_2, ...


2. date_of_birth: the year range can be from 2015 to 2025

3. num_of_tricks: range is 0 to 10

3. age: range is 1 to 10

4. country can be in {"USA", "CANADA", "FRANCE", "CHINA", "GERMANY"}

5. gender can be in {"MALE", "FEMALE"}

6. The breed can be in {'Persian', ...} as listed above

7. Do not distribute data evenly among countries and breed, and gender

8. English/SQL Queries: present these in markdown format: for students and instructor
   -- Come up with 20 basic  English/SQL queries
   -- Come up with 20 basic-to-intermediate  English/SQL queries
   -- Come up with 20 intermediate  English/SQL queries
   -- Come up with 20 intermediate++  English/SQL queries (include sub-queries using WITH
      and some basic ranking functions)

9. Include a starter Jupyter notebook for this data

10. All of these in one single downloadable zip file.

