# Storing Images in MySQL (JPG/PNG) — Complete Tutorial

## 1. Create a Simple Table

```sql
CREATE TABLE images_table (
    id INT  PRIMARY KEY,
    name VARCHAR(100),
    image_data LONGBLOB
);
```

## 2. Insert Image Files Using `LOAD_FILE()`

Make sure the image exists on the MySQL server machine and is readable.

### Insert JPG:

```sql
INSERT INTO images_table (`id`, `name`, `image_data`)
VALUES
(1, 'mono',   LOAD_FILE('/usr/local/mysql_files/cats/cat1.jpeg')),
(2, 'pishi',  LOAD_FILE('/usr/local/mysql_files/cats/cat2.jpeg')),
(3, 'salt',   LOAD_FILE('/usr/local/mysql_files/cats/cat3.jpeg')),
(4, 'pepper', LOAD_FILE('/usr/local/mysql_files/cats/cat4.jpeg'));

mysql> select id, name from images_table;
+----+--------+
| id | name   |
+----+--------+
|  1 | mono   |
|  2 | pishi  |
|  3 | salt   |
|  4 | pepper |
+----+--------+
4 rows in set (0.000 sec)
```

### Insert PNG:

```sql
INSERT INTO images_table (name, image_data)
VALUES ('logo', LOAD_FILE('/path/to/logo.png'));
```

### Check allowed directory:

```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

Place your image files inside the allowed directory.

---

## 3. Query Image Metadata

```sql
SELECT id, name, LENGTH(image_data) AS bytes
FROM images_table;
```

---

## 4. Retrieve Image Blob

```sql
SELECT image_data
FROM images_table
WHERE name = 'mono';
```

---

## 5. Insert Images Using Python (Recommended)

```python
cursor.execute(
    "INSERT INTO images_table (id, name, image_data) VALUES (%s, %s, %s)",
    (33, "cat_photo", open("cat.jpg", "rb").read())
)
```

---

