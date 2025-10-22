# Sales Analysis with MySQL + Python

## Requirements
Install dependencies:
```bash
pip install pandas matplotlib mysql-connector-python
```

## Steps
1. Load the `sales` table into MySQL:

```sql
CREATE TABLE sales (
    id INT PRIMARY KEY,
    region VARCHAR(20),
    product VARCHAR(20),
    quantity INT,
    price DECIMAL(8,2)
);

INSERT INTO sales VALUES
(1, 'East', 'Laptop', 3, 1200),
(2, 'East', 'Phone', 5, 800),
(3, 'East', 'Tablet', 2, 600),
(4, 'West', 'Laptop', 4, 1150),
(5, 'West', 'Phone', 6, 750),
(6, 'West', 'Tablet', 3, 620),
(7, 'North', 'Laptop', 2, 1250),
(8, 'North', 'Phone', 7, 820),
(9, 'North', 'Tablet', 4, 610),
(10, 'East', 'Laptop', 1, 1180),
(11, 'West', 'Phone', 8, 770),
(12, 'North', 'Tablet', 5, 605);
```

2. Edit `sales_analysis_mysql.py` with your MySQL username, password, and database.

3. Run the script:
```bash
python sales_analysis_mysql.py
```

It will:
- Print data summaries
- Run some GROUP BY queries
- Show bar charts
