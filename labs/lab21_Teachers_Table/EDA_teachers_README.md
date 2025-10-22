Consider the following  table in MySQL:

1. provide a python program to read teachers table
from mysql and then do explatory analysis of this 
data, and then some basic interesting "group by"
operations with plots.

2. provide the same thing as 1, but in jupyter notebook



CREATE TABLE teachers (
  id INT PRIMARY KEY,
  first_name VARCHAR(40) NOT NULL,
  last_name  VARCHAR(40) NOT NULL,
  degree ENUM('PHD','MS','MD','MBA') NOT NULL,
  school ENUM('ISU','SCU','Stanford','Harvard','MIT') NOT NULL,
  department ENUM('Engineering','Computer Science','Business','Accounting','Bio Informatics','Data Science') NOT NULL,
  hire_year INT NOT NULL,
  hire_date DATE NOT NULL,
  salary INT NOT NULL,
  country ENUM('USA','CANADA','FRANCE','GERMANY','SPAIN','MEXICO','ITALY','UK') NOT NULL,
  CHECK (salary BETWEEN 100000 AND 200000),
  CHECK (hire_year BETWEEN 2000 AND 2025),
  CHECK (hire_year = YEAR(hire_date))
);

✅ All set! I’ve created both:
    1.    teachers_eda.py → Python program that connects to MySQL, loads the teachers table, performs exploratory analysis, and generates group-by plots.
    2.    teachers_eda_notebook.ipynb → Jupyter Notebook version with step-by-step cells for interactive teaching.

📦 Download them here: teachers_mysql_eda.zip

Would you like me to also add a salary distribution histogram and boxplot in both script and notebook, so students can visualize variation more clearly? ￼

✅ Added!
Both the Python script and the Jupyter Notebook now include:
    •    📊 Salary distribution histogram
    •    📦 Salary distribution boxplot

These will help students visualize how salaries vary.

📦 Download the updated package here: teachers_mysql_eda_with_salaryplots.zip

Would you also like me to add a salary by degree/school boxplot (to compare distributions across groups)? ￼

