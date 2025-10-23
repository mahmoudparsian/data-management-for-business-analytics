# Music Database SQL Practice

This package contains SQL practice queries 
(basic, intermediate, and advanced) for the 
music streaming schema. 

Each query set is provided in two versions:

- **Student version**: English questions only

- **Instructor version**: English questions with SQL solutions

## 📂 Files
- `queries_1_basic_students.md`
- `queries_1_basic_instructor.md`
- `queries_2_intermediate_students.md`
- `queries_2_intermediate_instructor.md`
- `queries_3_advanced_students.md`
- `queries_3_advanced_instructor.md`

## 🗄️ Database Schema
The database contains the following tables:
- **users(user_id, user_name, email, country, plan)**
- **songs(song_id, title, artist, genre, duration)**
- **dates(date_id, play_date, year, month, day, quarter)**
- **devices(device_id, device)**
- **plays(play_id, user_id, song_id, date_id, device_id)**

## ▶️ How to Load Schema in MySQL

1. Open MySQL client or MySQL Workbench.
2. Run the provided schema creation SQL script (create all tables and insert data).
3. Verify that all tables are populated:
   ```sql
   SHOW TABLES;
   SELECT COUNT(*) FROM users;
   SELECT COUNT(*) FROM songs;
   SELECT COUNT(*) FROM plays;
   ```

## ▶️ How to Run Queries

1. Pick a query from the **student** files.
2. Try to write the SQL yourself.
3. Check the **instructor** file for the SQL solution.
4. Run the query in MySQL to see results.

## 🎯 Suggested Workflow for Students

1. Start with the **basic queries** to practice simple SELECTs, filters, and ordering.
2. Move to the **intermediate queries** for GROUP BY, joins, and aggregations.
3. Try the **intermediate++ queries** to learn CTEs (`WITH`) and ranking functions.

---
Happy querying! 🚀
