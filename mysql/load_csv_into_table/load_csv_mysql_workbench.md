# How to Load a CSV File into MySQL <br> Using MySQL Workbench

## 1. Using MySQL Workbench’s "Table Data Import Wizard" (GUI)

### Prerequisites
- MySQL Workbench is installed and you can connect to your MySQL server.
- You have a target schema (database).
- Your CSV is clean: consistent delimiters (`,`), quoted text if needed, and dates in `YYYY-MM-DD`.

### Steps
1. Open **Workbench** → connect to your server.
2. In **Navigator → SCHEMAS**, right-click your schema → choose **Table Data Import Wizard**.
3. Select the **CSV file** from your computer.
4. Choose a **Target Schema** and either:
   - Create a new table (Workbench infers columns), or  
   - Use an existing table (map columns).
5. Configure settings:
   - File encoding (usually UTF-8),
   - Field separator (`,`),
   - “First Row Contains Column Names” (check if CSV has headers).
6. Review inferred column types (change `VARCHAR`, `INT`, `DECIMAL`, `DATE` as needed).
7. Click **Next → Next → Finish**.
8. Verify:

   ```sql
   SELECT COUNT(*) 
   FROM your_table;
   
   SELECT * 
   FROM your_table 
   LIMIT 10;
   ```

### Windows vs macOS differences
- **UI/steps are the same**.  
- Only difference is file paths (e.g., `C:\Users\you\file.csv` vs `/Users/you/file.csv`).

---

## 2. Troubleshooting

**LOCAL INFILE not allowed**  
- Enable in Workbench: Connection → **Advanced** → Allow LOCAL INFILE = true.  
- On server (`my.cnf` / `my.ini`):
  ```
  [mysqld]
  local_infile=1
  ```
