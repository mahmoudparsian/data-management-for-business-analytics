# Students Table EDA

This package contains:
- `students_single_table_eda.py`: Python script to connect to MySQL, read the students table, and plot analysis
- `students_single_table_eda.ipynb`: Jupyter notebook version for interactive exploration

## Setup

1. Install requirements:
   ```bash
   pip install pandas matplotlib seaborn mysql-connector-python
   ```

2. Edit MySQL connection in script/notebook (`host`, `user`, `password`, `database`).

3. Run script:
   ```bash
   python students_single_table_eda.py
   ```

Or open notebook:
   ```bash
   jupyter notebook students_single_table_eda.ipynb
   ```

## Analysis
- Summary statistics of the students table
- Number of students per grade level
- Average GPA per grade level
- GPA distribution by enrollment status
- Average age per grade level
