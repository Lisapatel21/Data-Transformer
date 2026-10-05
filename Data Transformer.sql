CREATE DATABASE DataTransformer;
OUTPUT:
Query OK, 1 row affected (0.204 sec)

USE DataTransformer;
OUTPUT:
Database changed

CREATE TABLE Customers (

    CustomerID INT PRIMARY KEY,

    FirstName VARCHAR(50),

    LastName VARCHAR(50),

    Email VARCHAR(100),

    RegistrationDate DATE

);
OUTPUT:
Query OK, 0 rows affected (0.370 sec)

INSERT INTO Customers

(CustomerID, FirstName, LastName, Email, RegistrationDate)

VALUES

(1, 'John', 'Doe', 'john.doe@email.com', '2022-03-15'),

(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02');
OUTPUT:
Query OK, 2 rows affected (0.120 sec)
Records: 2  Duplicates: 0  Warnings: 0

CREATE TABLE Orders (

    OrderID INT PRIMARY KEY,

    CustomerID INT,

    OrderDate DATE,

    TotalAmount DECIMAL(10,2),

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)

);
OUTPUT:
Query OK, 0 rows affected (0.364 sec)

INSERT INTO Orders

(OrderID, CustomerID, OrderDate, TotalAmount)

VALUES

(101, 1, '2023-07-01', 150.50),

(102, 2, '2023-07-03', 200.75);
OUTPUT:
Query OK, 2 rows affected (0.163 sec)
Records: 2  Duplicates: 0  Warnings: 0

CREATE TABLE Employees (

    EmployeeID INT PRIMARY KEY,

    FirstName VARCHAR(50),

    LastName VARCHAR(50),

    Department VARCHAR(50),

    HireDate DATE,

    Salary DECIMAL(10,2)

);
OUTPUT:
Query OK, 0 rows affected (0.259 sec)

INSERT INTO Employees

(EmployeeID, FirstName, LastName, Department, HireDate, Salary)

VALUES

(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),

(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000.00);
OUTPUT:
Query OK, 2 rows affected (0.122 sec)
Records: 2  Duplicates: 0  Warnings: 0

1. INNER JOIN

SELECT

    Orders.OrderID,

    Customers.FirstName,

    Customers.LastName,

    Orders.OrderDate,

    Orders.TotalAmount

FROM Orders

INNER JOIN Customers

ON Orders.CustomerID = Customers.CustomerID;
OUTPUT:
+---------+-----------+----------+------------+-------------+
| OrderID | FirstName | LastName | OrderDate  | TotalAmount |
+---------+-----------+----------+------------+-------------+
|     101 | John      | Doe      | 2023-07-01 |      150.50 |
|     102 | Jane      | Smith    | 2023-07-03 |      200.75 |
+---------+-----------+----------+------------+-------------+
2 rows in set (0.080 sec)

2. LEFT JOIN

SELECT

    Customers.CustomerID,

    Customers.FirstName,

    Customers.LastName,

    Orders.OrderID,

    Orders.TotalAmount

FROM Customers

LEFT JOIN Orders

ON Customers.CustomerID = Orders.CustomerID;
OUTPUT:
+------------+-----------+----------+---------+-------------+
| CustomerID | FirstName | LastName | OrderID | TotalAmount |
+------------+-----------+----------+---------+-------------+
|          1 | John      | Doe      |     101 |      150.50 |
|          2 | Jane      | Smith    |     102 |      200.75 |
+------------+-----------+----------+---------+-------------+
2 rows in set (0.084 sec)

3. RIGHT JOIN

SELECT

    Customers.CustomerID,

    Customers.FirstName,

    Customers.LastName,

    Orders.OrderID,

    Orders.TotalAmount

FROM Customers

RIGHT JOIN Orders

ON Customers.CustomerID = Orders.CustomerID;
OUTPUT:
+------------+-----------+----------+---------+-------------+
| CustomerID | FirstName | LastName | OrderID | TotalAmount |
+------------+-----------+----------+---------+-------------+
|          1 | John      | Doe      |     101 |      150.50 |
|          2 | Jane      | Smith    |     102 |      200.75 |
+------------+-----------+----------+---------+-------------+
2 rows in set (0.011 sec)

4. FULL OUTER JOIN

SELECT

    Customers.CustomerID,

    Customers.FirstName,

    Customers.LastName,

    Orders.OrderID,

    Orders.TotalAmount

FROM Customers

LEFT JOIN Orders

ON Customers.CustomerID = Orders.CustomerID

UNION

SELECT

    Customers.CustomerID,

    Customers.FirstName,

    Customers.LastName,

    Orders.OrderID,

    Orders.TotalAmount

FROM Customers

RIGHT JOIN Orders

ON Customers.CustomerID = Orders.CustomerID;
OUTPUT:
+------------+-----------+----------+---------+-------------+
| CustomerID | FirstName | LastName | OrderID | TotalAmount |
+------------+-----------+----------+---------+-------------+
|          1 | John      | Doe      |     101 |      150.50 |
|          2 | Jane      | Smith    |     102 |      200.75 |
+------------+-----------+----------+---------+-------------+
2 rows in set (0.147 sec)

5. SUBQUERY

-- Find customers who have placed orders

-- worth more than the average order amount

SELECT *FROM Customers

WHERE CustomerID IN

(

    SELECT CustomerID

    FROM Orders

    WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders)

);
OUTPUT:
+------------+-----------+----------+----------------------+------------------+
| CustomerID | FirstName | LastName | Email                | RegistrationDate |
+------------+-----------+----------+----------------------+------------------+
|          2 | Jane      | Smith    | jane.smith@email.com | 2021-11-02       |
+------------+-----------+----------+----------------------+------------------+
1 row in set (0.185 sec)

6. SUBQUERY

-- Find employees whose salary is above the average salar

SELECT *FROM Employees

WHERE Salary > (SELECT AVG(Salary) FROM Employees);
OUTPUT:
+------------+-----------+----------+------------+------------+----------+
| EmployeeID | FirstName | LastName | Department | HireDate   | Salary   |
+------------+-----------+----------+------------+------------+----------+
|          2 | Susan     | Lee      | HR         | 2021-03-20 | 55000.00 |
+------------+-----------+----------+------------+------------+----------+
1 row in set (0.015 sec)

7. Extract year and month from OrderDate

SELECT

    OrderID,

    OrderDate,

    YEAR(OrderDate) AS OrderYear,

    MONTH(OrderDate) AS OrderMonth

FROM Orders;
OUTPUT:
+---------+------------+-----------+------------+
| OrderID | OrderDate  | OrderYear | OrderMonth |
+---------+------------+-----------+------------+
|     101 | 2023-07-01 |      2023 |          7 |
|     102 | 2023-07-03 |      2023 |          7 |
+---------+------------+-----------+------------+
2 rows in set (0.126 sec)

8. Calculate the difference in days
 between OrderDate and current date

SELECT

    OrderID,

    OrderDate,

    DATEDIFF(CURDATE(), OrderDate) AS DaysDifference

FROM Orders;
OUTPUT:
+---------+------------+----------------+
| OrderID | OrderDate  | DaysDifference |
+---------+------------+----------------+
|     101 | 2023-07-01 |           1192 |
|     102 | 2023-07-03 |           1190 |
+---------+------------+----------------+
2 rows in set (0.065 sec)

9. Format OrderDate into a readable format

SELECT

    OrderID,

    DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate

FROM Orders;
OUTPUT:
+---------+---------------+
| OrderID | FormattedDate |
+---------+---------------+
|     101 | 01-Jul-2023   |
|     102 | 03-Jul-2023   |
+---------+---------------+
2 rows in set (0.107 sec)

10. Concatenate FirstName and LastName

SELECT

    CustomerID,

    CONCAT(FirstName, ' ', LastName) AS FullName

FROM Customers;
OUTPUT:
+------------+------------+
| CustomerID | FullName   |
+------------+------------+
|          1 | John Doe   |
|          2 | Jane Smith |
+------------+------------+
2 rows in set (0.010 sec)

11. Replace part of a string

 Example: replace John with Jonathan

SELECT

    FirstName,

    REPLACE(FirstName, 'John', 'Jonathan') AS NewFirstName

FROM Customers;
OUTPUT:
+-----------+--------------+
| FirstName | NewFirstName |
+-----------+--------------+
| John      | Jonathan     |
| Jane      | Jane         |
+-----------+--------------+
2 rows in set (0.010 sec)

12. Convert FirstName to uppercase
and LastName to lowercase

SELECT

    UPPER(FirstName) AS FirstNameUpper,

    LOWER(LastName) AS LastNameLower

FROM Customers;
OUTPUT:
+----------------+---------------+
| FirstNameUpper | LastNameLower |
+----------------+---------------+
| JOHN           | doe           |
| JANE           | smith         |
+----------------+---------------+
2 rows in set (0.094 sec)

13. Remove extra spaces from Email

SELECT

    CustomerID,

    TRIM(Email) AS CleanEmail

FROM Customers;
OUTPUT:
+------------+----------------------+
| CustomerID | CleanEmail           |
+------------+----------------------+
|          1 | john.doe@email.com   |
|          2 | jane.smith@email.com |
+------------+----------------------+
2 rows in set (0.087 sec)

14. Calculate running total of TotalAmount

SELECT

    OrderID,

    OrderDate,

    TotalAmount,

    SUM(TotalAmount) OVER (

        ORDER BY OrderDate

    ) AS RunningTotal

FROM Orders;
OUTPUT:
+---------+------------+-------------+--------------+
| OrderID | OrderDate  | TotalAmount | RunningTotal |
+---------+------------+-------------+--------------+
|     101 | 2023-07-01 |      150.50 |       150.50 |
|     102 | 2023-07-03 |      200.75 |       351.25 |
+---------+------------+-------------+--------------+
2 rows in set (0.133 sec)

15. Rank orders based on TotalAmount

SELECT

    OrderID,

    TotalAmount,

    RANK() OVER (

        ORDER BY TotalAmount DESC

    ) AS OrderRank

FROM Orders;
OUTPUT:
+---------+-------------+-----------+
| OrderID | TotalAmount | OrderRank |
+---------+-------------+-----------+
|     102 |      200.75 |         1 |
|     101 |      150.50 |         2 |
+---------+-------------+-----------+
2 rows in set (0.022 sec)

16. Assign discount based on TotalAmount

-- More than 1000 = 10%

-- More than 500 = 5%

-- Otherwise = 0%

SELECT

    OrderID,

    TotalAmount,

    CASE

        WHEN TotalAmount > 1000 THEN '10%'

        WHEN TotalAmount > 500 THEN '5%'

        ELSE '0%'

    END AS Discount

FROM Orders;
OUTPUT:
+---------+-------------+----------+
| OrderID | TotalAmount | Discount |
+---------+-------------+----------+
|     101 |      150.50 | 0%       |
|     102 |      200.75 | 0%       |
+---------+-------------+----------+
2 rows in set (0.010 sec)

17. Categorize employee salaries

SELECT

    EmployeeID,

    FirstName,

    LastName,

    Salary,

    CASE

        WHEN Salary >= 50000 THEN 'High'

        WHEN Salary >= 30000 THEN 'Medium'

        ELSE 'Low'

    END AS SalaryCategory

FROM Employees;
OUTPUT:
+------------+-----------+----------+----------+----------------+
| EmployeeID | FirstName | LastName | Salary   | SalaryCategory |
+------------+-----------+----------+----------+----------------+
|          1 | Mark      | Johnson  | 50000.00 | High           |
|          2 | Susan     | Lee      | 55000.00 | High           |
+------------+-----------+----------+----------+----------------+
2 rows in set (0.011 sec)