# mysql8.0-employees

English | [日本語](./README_jp.md)

dockerhub url: https://hub.docker.com/r/ac0mz/mysql8.0-employees

## About
This Docker image is built to work on M1 Mac, referring to [genschsa/mysql-employees](https://hub.docker.com/r/genschsa/mysql-employees).

Since a table based on the [MySQL Employee Sample database](https://dev.mysql.com/doc/employee/en/) is created and data is insert when the container is started, it is an image that can be used immediately for development purposes and as a practice for MySQL. 

Insert over 300,000 records using some DDL in the repository [datacharmer/test_db](https://github.com/datacharmer/test_db) on github.

It is based on the Docker image of [mysql-server8.0 published by MySQL](https://hub.docker.com/r/mysql/mysql-server).

It exposes port 3306 and supports a mountable volume at `/var/lib/mysql` for persistent data.


## Make own yourself
If you want to create the container image yourself, execute the following command.

```sh
# make sure mysql-employees is the current directory.
pwd
# > /Users/YOUR_NAME/mysql-employees

# prepare the DDL for data input.
git clone https://github.com/datacharmer/test_db.git

# create a script to be automatically executed after the container is started.
mkdir docker-entrypoint-initdb.d && cd $_
cat <<EOF > initdb.sh
#echo 'Environment:' && env

echo 'Loading employee database...'
cd /initdb/test_db
mysql -uroot -p$MYSQL_ROOT_PASSWORD < initdb.sql
EOF

# create a DDL for creating a mysql user.
# create a password with mysql_native_password so that you can connect from an external client.
cd - && mkdir initdb && cd $_
cat <<EOF > users.sql
SELECT 'Configuring Users...' as 'INFO';

CREATE USER sa_empapi@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT SELECT ON employees.* TO sa_empapi@'%';

CREATE USER sa_empmsg@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT SELECT, INSERT, UPDATE, DELETE ON employees.* TO sa_empmsg@'%';

CREATE USER emp_api_web@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT ALL PRIVILEGES ON employees.* TO emp_api_web@'%';

CREATE USER gnuser@'%' IDENTIFIED WITH mysql_native_password BY 'college';
GRANT ALL PRIVILEGES ON employees.* TO gnuser@'%' WITH GRANT OPTION;
EOF

# copy the DDL from datacharmer/test_db.
mkdir test_db && cd ../test_db
cp employees.sql load_departments.dump load_dept_emp.dump load_dept_manager.dump load_employees.dump load_salaries1.dump load_salaries2.dump load_salaries3.dump load_titles.dump objects.sql show_elapsed.sql sql_test.sh test_employees_md5.sql test_employees_sha.sql ../initdb/test_db
cd ../../

# create a container image.
docker image build -t mysql-employees:8.0.27-aarch64 .
```


## Usage
```sh
# run in the background. (deleted by --rm option when the container is stopped.)
docker container run -d --rm \
  --name mysql-employee-v8 \
  -p 33060:3306 \
  -e MYSQL_ROOT_PASSWORD=college \
  -v $PWD/data:/var/lib/mysql \
  mysql-employees:8.0.27-aarch64

# check the status of the container and wait until [health: starting] -> [healthy].
docker container ls

# connect to the container.
docker container exec -it mysql-employee-8 bash

# connect to mysql (password is already set as an environment variable when starting the container).
mysql -uroot -p$MYSQL_ROOT_PASSWORD employees
# make sure you can find some records.
select * from employees limit 5;
```


## Appendix

### MySQL 5.7 image cannot be created
Regarding linux/arm64 (aarch64) which is the target platform of M1 Mac, there is no explanation on this [MySQL 5.7 official page](https://dev.mysql.com/doc/refman/5.7/en/linux-installation-yum-repo.html), but the [MySQL 8.0 official page](https://dev.mysql.com/doc/refman/8.0/en/linux-installation-yum-repo.html) has the following description.

>ARM 64-bit (aarch64) is supported on Oracle Linux 7 as of MySQL 8.0.12.

In other words, you cannot create an image of MySQL 5.7 for M1 Mac.

[the official MySQL Docker image](https://hub.docker.com/_/mysql/) only provides linux/amd64 (x86_64), and the M1 Mac should use [mysql-server](https://hub.docker.com/r/mysql/mysql-server), which is also provided on the linux/arm64 platform. Linux/arm64 is provided with MySQL8.0 and above.


### Insert of initial data
The base image (mysql-server) is configured to automatically execute scripts that exist in the directory `/docker-entrypoint-initdb.d` in the container when the container starts.

Following to this mechanism, Dockerfile is defined to copy the data input script to `/docker-entrypoint-initdb.d`.
Data input is realized by pouring `/init/test_db/initdb.sql` into MySQL in the script.

For details, please refer to the description of Make-own-yourself on this page.
