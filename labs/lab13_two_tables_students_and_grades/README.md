# Students & Grades EDA

This package contains:

- `students_grades_eda.py`: 

		Python script to connect to MySQL, 
		read tables, and plot analysis

- `students_grades_eda.ipynb`: 

		Jupyter notebook version for 
		interactive exploration

## Setup

1. Install requirements:
   ```bash
   pip install pandas matplotlib seaborn mysql-connector-python
   ```

2. Edit MySQL connection in script/notebook (`host`, `user`, `password`, `database`).

3. Run script:
   ```bash
   python3 students_grades_eda.py
   ```

Or open notebook:
   ```bash
   jupyter notebook students_grades_eda.ipynb
   ```

## Analysis
- Number of students per grade level
- Average scores per grade level
- Average scores per course
- Average scores per semester
