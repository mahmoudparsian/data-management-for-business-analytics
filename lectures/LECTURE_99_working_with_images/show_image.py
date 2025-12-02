#!/usr/bin/env python3

"""
Python program to fetch an image (BLOB) from MySQL
table called images_table defined as:

		CREATE TABLE images_table (
			id INT  PRIMARY KEY,
			name VARCHAR(100),
			image_data LONGBLOB
		);
		
		mysql> select id, name, length(image_data) from images_table;
		+----+--------+--------------------+
		| id | name   | length(image_data) |
		+----+--------+--------------------+
		|  1 | mono   |               4594 |
		|  2 | pishi  |               4837 |
		|  3 | salt   |               6895 |
		|  4 | pepper |               5739 |
		+----+--------+--------------------+
		4 rows in set (0.001 sec)

Parameter to Python program:

id as an integer: 
using images_table.id and display it on screen.

Usage:
    python3 show_image.py 1
"""

import sys
import mysql.connector
from PIL import Image
import io



image_id = int(sys.argv[1])
print("image id=", image_id)

# ---- Update these settings to match your MySQL database ----
db_config = {
	"user": "root",
	"password": "mp22pass",
	"host": "localhost",
	"database": "cat_images"
}

try:
	conn = mysql.connector.connect(**db_config)
	cursor = conn.cursor()

	query = "SELECT image_data FROM images_table WHERE id = %s"
	cursor.execute(query, (image_id,))
	row = cursor.fetchone()

	if row is None:
		print(f"No image found with id={image_id}")
		exit(1)

	image_blob = row[0]

	# Convert BLOB → BytesIO → PIL Image
	image = Image.open(io.BytesIO(image_blob))
	image.show()

except mysql.connector.Error as err:
	print("MySQL Error:", err)

finally:
	if conn.is_connected():
		cursor.close()
		conn.close()

