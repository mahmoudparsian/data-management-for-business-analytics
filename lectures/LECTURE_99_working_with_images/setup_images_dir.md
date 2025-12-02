✅ 1. MySQL Configuration File

Edit and create a directory for your images

```
% cat /usr/local/mysql/my.cnf
[mysqld]
secure_file_priv=/usr/local/mysql_files/
```
-----

✅ 2. Check MySQL 

```
mysql> SHOW VARIABLES LIKE 'secure_file_priv';
+------------------+-------------------------+
| Variable_name    | Value                   |
+------------------+-------------------------+
| secure_file_priv | /usr/local/mysql_files/ |
+------------------+-------------------------+
1 row in set (0.002 sec)
```
-----

✅  3. Create a directory for MySQL files

```
mkdir -p /Users/max/mysql_files
sudo chown _mysql:_mysql /Users/max/mysql_files
```


