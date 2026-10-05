[README (2).md](https://github.com/user-attachments/files/33058924/README.2.md)
# Data Transformer 🗄️✨

Data Transformer is a small MySQL project that uses customer, order, and employee data to practice writing SQL queries and transforming data in different ways. 💻

## About the Project 📖

This project is created to practice and demonstrate SQL database operations, joins, subqueries, date functions, string functions, window functions, and conditional statements. The database is called `DataTransformer` and it has three tables with some sample records to run the queries on.

## Database Structure 🧱

The database has three main tables:

**👥 Customers**
- CustomerID (Primary Key)
- FirstName
- LastName
- Email
- RegistrationDate

**🛒 Orders**
- OrderID (Primary Key)
- CustomerID (Foreign Key)
- OrderDate
- TotalAmount

**💼 Employees**
- EmployeeID (Primary Key)
- FirstName
- LastName
- Department
- HireDate
- Salary

The `Customers` and `Orders` tables are related through `CustomerID`. The `CustomerID` column in `Orders` is a foreign key that points to `Customers.CustomerID`, so every order belongs to one customer. The `Employees` table is separate and is used for the salary and date based queries.

```
Customers (CustomerID)  --->  Orders (CustomerID)
```

## SQL Concepts Used 🧠

- 🏗️ Creating a database
- 📌 Selecting a database using `USE`
- 📋 Creating tables
- ✍️ Inserting records
- 🔑 Primary keys
- 🔗 Foreign keys
- 🤝 `INNER JOIN`
- ⬅️ `LEFT JOIN`
- ➡️ `RIGHT JOIN`
- 🔄 `FULL OUTER JOIN` using `LEFT JOIN` + `RIGHT JOIN` with `UNION`
- 🔍 Subqueries
- 📈 Finding values above average
- 📅 Extracting year and month using `YEAR()` and `MONTH()`
- ⏳ Calculating date differences using `DATEDIFF()`
- 🗓️ Formatting dates using `DATE_FORMAT()`
- 🧵 Concatenating strings using `CONCAT()`
- ✏️ Replacing text using `REPLACE()`
- 🔠 Converting text using `UPPER()` and `LOWER()`
- ✂️ Removing extra spaces using `TRIM()`
- ➕ Running totals using `SUM() OVER()`
- 🏆 Ranking using `RANK() OVER()`
- 🔀 Conditional logic using `CASE`
- 💰 Categorizing employee salaries using `CASE`

## Examples 💡

Some of the queries in this project:

- 🤝 Displaying customer order details using `INNER JOIN`
- 📊 Finding customers with orders above the average order amount
- 💵 Finding employees with above-average salaries
- ➕ Calculating running totals
- 🏆 Ranking orders
- 🎁 Assigning discounts
- 💰 Categorizing employee salaries

A small example of the kind of query used:

```sql
SELECT c.FirstName, c.LastName, o.OrderID, o.TotalAmount
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;
```

## How to Run ▶️

1. 🔓 Open MySQL Command Line Client and enter your password.
2. 🏗️ Run the query to create the database:
   ```sql
   CREATE DATABASE DataTransformer;
   ```
3. 📌 Select the database:
   ```sql
   USE DataTransformer;
   ```
4. 📋 Create the tables (`Customers`, `Orders`, and `Employees`).
5. ✍️ Insert the records into each table.
6. ▶️ Run each SQL query one by one.
7. ✅ Check the output after each query.

## Tools Used 🛠️

- 🐬 MySQL
- ⌨️ MySQL Command Line Client

## Author 👩‍💻

Author: Lisa Patel

⭐ Thank you for checking out my project!
