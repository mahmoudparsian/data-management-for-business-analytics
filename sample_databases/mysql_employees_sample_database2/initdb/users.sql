SELECT 'Configuring Users...' as 'INFO';

CREATE USER sa_empapi@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT SELECT ON employees.* TO sa_empapi@'%';

CREATE USER sa_empmsg@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT SELECT, INSERT, UPDATE, DELETE ON employees.* TO sa_empmsg@'%';

CREATE USER emp_api_web@'%' IDENTIFIED WITH mysql_native_password BY 'secr3T#1';
GRANT ALL PRIVILEGES ON employees.* TO emp_api_web@'%';

CREATE USER gnuser@'%' IDENTIFIED WITH mysql_native_password BY 'college';
GRANT ALL PRIVILEGES ON employees.* TO gnuser@'%' WITH GRANT OPTION;
