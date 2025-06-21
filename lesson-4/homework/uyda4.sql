Write a query to select the top 5 employees from the Employees table.
select top 5 *from employees
Use SELECT DISTINCT to select unique Category values from the Products table.
select distinct Category from products
Write a query that filters the Products table to show products with Price > 100.
select *from products
where price>100
Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
select*from Customers
where firstname like 'A%'
Order the results of a Products table by Price in ascending order.
select*from products
order by Price asc
Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
select*from  employees where salary>=6000 and DepartmentName='HR'
Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
select isnull(Email, 'noemail@example.com') as Email
from Employees;
Write a query that shows all products with Price BETWEEN 50 AND 100.
select*from products
where price between 50 and 100
Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName
FROM Products;
After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;
Write a query to select the top 10 products from the Products table, ordered by Price DESC.
SELECT TOP 10 *
FROM Products
ORDER BY Price DESC;
Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
SELECT COALESCE(FirstName, LastName) AS Name
FROM Employees;
Write a query that selects distinct Category and Price from the Products table.
SELECT DISTINCT Category, Price
FROM Products
Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR DepartmentName = 'Marketing';
Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;
Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
select *
from Products
where Price <= 1000 AND StockQuantity > 50
order by StockQuantity ASC;
Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
select *
from Products
where ProductName LIKE '%e%';
Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
select *
from Employees
where Department IN ('HR', 'IT', 'Finance');
Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table
select *
fromCustomers
order by City asc, PostalCode desc
Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC.
select top(5) *
from Products
order bY SalesAmount desc;
select*from products
Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)
select FirstName + ' ' + LastName AS FullName
from  Employees;
Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
select distinct Category, ProductName, Price
from Products
where Price > 50;

Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products)
select ProductName, Price
from  Products
where Price < 0.1 * (select avg(Price) from Products)
Use where clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
select*from employees
where age<30 and departmentName in ('HR','IT')
Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
select *
from  Customers
where Email LIKE '%@gmail.com%';
Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
select *from  Employees where Salary > ALL (
 select Salary from Employees where DepartmentName = 'Sales');
Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date)
select *from  Orders where OrderDate BETWEEN DATEADD(day, -180, GETDATE()) AND GETDATE();
