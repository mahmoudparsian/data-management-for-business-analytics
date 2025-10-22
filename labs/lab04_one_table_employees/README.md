# Employees Table EDA

This package contains:
- `employees_single_table_eda.py`: Python script to connect to MySQL, read the employees table, and plot analysis
- `employees_single_table_eda.ipynb`: Jupyter notebook version for interactive exploration

## Setup

1. Install requirements:
   ```bash
   pip install pandas matplotlib seaborn mysql-connector-python
   ```

2. Edit MySQL connection in script/notebook (`host`, `user`, `password`, `database`).

3. Run script:
   ```bash
   python employees_single_table_eda.py
   ```

Or open notebook:
   ```bash
   jupyter notebook employees_single_table_eda.ipynb
   ```

## Analysis
- Summary statistics of the employees table
- Number of employees per department
- Average salary per department
- Salary distribution
- Age distribution per department
