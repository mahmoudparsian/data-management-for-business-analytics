
# SQL Week-1 & Week-2 Teaching Module

**Generated:** 2025-11-10

## Files
- `week1.md` — Fundamentals (PK/FK, SELECT, WHERE, ORDER BY, LIMIT) with examples.
- `week2.md` — GROUP BY, HAVING, JOINs (INNER/LEFT/RIGHT) with examples.
- `student_worksheet.md` — Questions only.
- `teacher_answer_key.md` — Solutions for all questions.
- `module_tables.sql` — Complete MySQL schema + seed data. Run this first.

## Quick Start
```sh
mysql -u root -p < module_tables.sql
# then connect to MySQL and:
USE module_db;
SELECT COUNT(*) FROM students;
```

## Notes
- Uses `GROUP_CONCAT` (MySQL function).
- Auto-increment starting IDs are assumed to match insert order for tests; if not, query by names.
