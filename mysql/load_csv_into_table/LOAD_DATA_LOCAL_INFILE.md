# How to Load a CSV File into MySQL <br> Using LOAD DATA [LOCAL] INFILE


------

## 1. Using SQL: `LOAD DATA [LOCAL] INFILE`

### Example Table
```sql
CREATE TABLE employees (
  employee_id INT,
  employee_name VARCHAR(100),
  age INT,
  country VARCHAR(50),
  department VARCHAR(50),
  position VARCHAR(50),
  salary DECIMAL(12,2),
  joined_date DATE
);
```

### Load the CSV
```sql
LOAD DATA LOCAL INFILE '/full/path/to/employee_records.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(employee_id, employee_name, age, country, department, position, salary, joined_date);
```

#### Tips
- **Windows** path example: `'C:\\Users\\you\\employee_records.csv'`
- **macOS** path example: `'/Users/you/employee_records.csv'`
- If dates aren’t `YYYY-MM-DD`, use `STR_TO_DATE()` in a staging column.

---

##  2. Troubleshooting

**1) LOCAL INFILE not allowed**  
- Enable in Workbench: Connection → **Advanced** → Allow LOCAL INFILE = true.  
- On server (`my.cnf` / `my.ini`):
  ```
  [mysqld]
  local_infile=1
  ```

**2) `secure_file_priv` restriction**  
- Check allowed folder:

  ```sql
  SHOW VARIABLES LIKE 'secure_file_priv';
  ```
- Move CSV there if needed, or use `LOAD DATA LOCAL INFILE`.

**3) Encoding issues**  
- Save file as **UTF-8**.  
- Add `CHARACTER SET utf8mb4` if needed.

**4) Date parse errors**  
Use `STR_TO_DATE()` mapping:
```sql
LOAD DATA LOCAL INFILE 'file.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(employee_id, employee_name, age, country, department, position, salary, @joined_raw)
SET joined_date = STR_TO_DATE(@joined_raw, '%m/%d/%Y');
```

---

## 3. Quick Verification
```sql
SELECT COUNT(*) AS rows_loaded 
FROM employees;

SELECT employee_name, salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;
```

---
