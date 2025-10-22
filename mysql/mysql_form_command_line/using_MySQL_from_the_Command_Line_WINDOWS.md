# 🎓 Using MySQL from the Command Line
# 🔹 On Windows 10/11

	I have successfully installed mysql on my laptop, 
	can you provide exact instructions to be able to 
	use mysql from the command line in a terminal for 
	both Mackbook and Windows 10/11 environments

	Perfect 👌 — let’s set up MySQL command line usage 
	for Windows 10/11 step by step.

⸻

## 1. Verify Installation

MySQL is usually installed at:

~~~
C:\Program Files\MySQL\MySQL Server 8.0\bin
~~~

⸻

## 2. Add MySQL to PATH

    1.    Press Win + R, type sysdm.cpl, hit Enter.
    2.    Go to Advanced → Environment Variables.
    3.    Under System variables, find Path, click Edit.
    4.    Add:

			C:\Program Files\MySQL\MySQL Server 8.0\bin

    5.    Click OK → OK.

⸻

## 3. Open Command Prompt (or PowerShell)

Run:

~~~
mysql -u root -p
~~~

Enter your root password when prompted.

⸻

## 4. Start / Stop MySQL Service

In PowerShell (as Admin):

~~~
# Start MySQL
net start MySQL80

# Stop MySQL
net stop MySQL80
~~~

⸻

## 🔹 Quick Test Commands 

		Once inside MySQL (mysql> prompt):
		
		-- Show available databases
		SHOW DATABASES;
		
		-- Create a test database
		CREATE DATABASE testdb;
		
		-- Switch to it
		USE testdb;
		
		-- Create a table
		CREATE TABLE users (
			id INT PRIMARY KEY,
			name VARCHAR(50)
		);
		
		-- Insert sample row
		INSERT INTO users VALUES (1, 'Alice');
		
		-- Query table
		SELECT * FROM users;


