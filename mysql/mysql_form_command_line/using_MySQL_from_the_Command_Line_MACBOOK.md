# 🎓 Using MySQL from the Command Line
# 🔹 On macOS (MacBook)

	I have successfully installed mysql on my laptop, 
	can you provide exact instructions to be able to 
	use mysql from the command line in a terminal for 
	both Mackbook and Windows 10/11 environments

	Perfect 👌 — let’s set up MySQL command line usage 
	for  MacBook (macOS) step by step.

⸻


## 1. Verify Installation

If you installed MySQL via Homebrew:

~~~
brew list | grep mysql
~~~

If installed via DMG package (MySQL installer), 
the binaries are typically under:

~~~
/usr/local/mysql/bin
~~~

⸻

## 2. Add MySQL to PATH (recommended)

Edit your shell configuration (.zshrc or .bash_profile):

~~~
bbedit ~/.zshrc
~~~

Add this line (adjust path if needed):

~~~
export PATH="/usr/local/mysql/bin:$PATH"
~~~

Save, then reload:

~~~
source ~/.zshrc
~~~

⸻

## 3. Connect to MySQL

Run from command line:

~~~
mysql -u root -p
~~~

    •    -u root → username
    •    -p → prompts for password

If successful, you’ll see the MySQL prompt:

~~~
mysql>
~~~

⸻

## 4. Stop / Start MySQL Server

If installed with Homebrew:

~~~
brew services start mysql
brew services stop mysql
~~~

If installed with DMG package, use System Preferences → MySQL pane.

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


