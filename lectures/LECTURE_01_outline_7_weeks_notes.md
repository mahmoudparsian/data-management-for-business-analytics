# Instructor’s Notes – MySQL / Relational Database 101 (7 Weeks, 40 Slides)

These notes follow the student slide deck (`mysql_relational_db_101.md`) slide-by-slide, giving teaching tips, expected outcomes, and common pitfalls.

---

## Week 1 – Introduction

**Slide 1: What is a Database?**
- Emphasize: database = organized collection of data.
- Common pitfall: Students confuse Excel spreadsheets with relational databases.

**Slide 2: Why Relational Databases?**
- Stress relationships (tables linked by keys).
- Example: Customers + Orders.
- Tip: Ask students to think of real-life examples (library books, student enrollments).

**Slide 3: What is SQL?**
- Note: SQL = Structured Query Language.
- Pitfall: Students think SQL is only for SELECT (but it’s also for INSERT, UPDATE, DELETE).

**Slide 4: MySQL Overview**
- Mention open source, widely used.
- Tip: Share installation guide links before class.

**Slide 5: Installing MySQL**
- Demo live if possible.
- Pitfall: Students often forget root password.

**Slide 6: Connecting to MySQL**
- Show `mysql -u root -p`.
- Tip: Walk around to check everyone connects successfully.

---

## Week 2 – Tables & SELECT

**Slide 7: Tables, Rows, Columns**
- Tip: Draw table structure on whiteboard.
- Pitfall: Students confuse schema vs data.

**Slide 8: Creating a Table**
- Emphasize correct data types.
- Pitfall: Using VARCHAR for everything.

**Slide 9: Inserting Data**
- Remind: Always match number of columns and values.

**Slide 10: Basic SELECT**
- Encourage students to try `SELECT *` and then specific columns.

**Slide 11: SELECT with Aliases**
- Show usefulness for readability.

**Slide 12: Practice**
- Ask: Create a “students” table with 3 rows.

---

## Week 3 – Filtering

**Slide 13: WHERE Clause**
- Common mistake: forgetting quotes around strings.

**Slide 14: Comparison Operators**
- Tip: Demonstrate `>`, `<`, `=` with numbers.

**Slide 15: Logical Operators**
- Emphasize `AND`, `OR`, `NOT`.

**Slide 16: ORDER BY**
- Pitfall: Students expect ORDER BY without ASC/DESC to default to descending.

**Slide 17: LIMIT**
- Use to prevent overwhelming outputs.

**Slide 18: Practice**
- Ask: Find all employees over 30, order by age.

---

## Week 4 – Aggregation

**Slide 19: COUNT, SUM**
- Tip: Show COUNT(*) vs COUNT(column).

**Slide 20: AVG, MIN, MAX**
- Pitfall: AVG only works on numeric columns.

**Slide 21: GROUP BY**
- Stress: SELECT must include grouped columns or aggregates.

**Slide 22: HAVING**
- Compare WHERE vs HAVING.

**Slide 23: Aggregation Example**
- Walk through line by line.

**Slide 24: Practice**
- Ask: Count employees per department.

---

## Week 5 – Joins & Keys

**Slide 25: Primary Key**
- Stress uniqueness and NOT NULL.

**Slide 26: Foreign Key**
- Emphasize referential integrity.

**Slide 27: INNER JOIN**
- Pitfall: Students expect non-matching rows to appear.

**Slide 28: LEFT JOIN**
- Emphasize NULLs when no match.

**Slide 29: RIGHT JOIN**
- Explain as mirror of LEFT JOIN.

**Slide 30: Practice**
- Ask: List all employees with department names.

---

## Week 6 – Subqueries & WITH

**Slide 31: Subquery in WHERE**
- Tip: Start simple with scalar subqueries.

**Slide 32: Subquery in FROM**
- Pitfall: Students forget to alias subquery.

**Slide 33: WITH Clause**
- Explain readability and reusability.

**Slide 34: Constraints**
- Show UNIQUE, CHECK.

**Slide 35: Practice**
- Ask: Find employees with salary above average.

**Slide 36: Practice**
- Ask: Use WITH to simplify query.

---

## Week 7 – Wrap-up

**Slide 37: Transactions**
- Show START TRANSACTION, COMMIT, ROLLBACK.
- Pitfall: Students forget COMMIT.

**Slide 38: Indexes**
- Emphasize faster lookups, but slower inserts.

**Slide 39: Best Practices**
- Stress meaningful column names, consistent style.

**Slide 40: Course Summary**
- Recap progression: Tables → SELECT → Joins → Aggregation → Subqueries → Transactions.

---

# Teaching Tips
- Always demo live in MySQL CLI or MySQL Workbench.
- Encourage students to type queries, not just copy-paste.
- Frequently ask “what do you expect this query to return?” before running it.
