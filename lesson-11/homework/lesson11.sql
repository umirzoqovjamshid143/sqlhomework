Easy-Level Tasks (7)

    Return: OrderID, CustomerName, OrderDate
    Task: Show all orders placed after 2022 along with the names of the customers who placed them.
    Tables Used: Orders, Customers
	select OrderID, CONCAT(FirstName,LastName ) as customername, OrderDate from Customers as c join Orders as o on  c.CustomerID=o.CustomerID
	where year(OrderDate)>2022
    Return: EmployeeName, DepartmentName
    Task: Display the names of employees who work in either the Sales or Marketing department.
    Tables Used: Employees, Departments
	select name, DepartmentName from Employees as e join Departments as d on e.DepartmentID=d.DepartmentID 
	where d.DepartmentName in ('Sales', 'Marketing')
    Return: DepartmentName, MaxSalary
    Task: Show the highest salary for each department.
    Tables Used: Departments, Employees
	select  DepartmentName, max(Salary) as maxsalary from employees as e join Departments as d on e.DepartmentID=d.DepartmentID 
	group by DepartmentName 
    Return: CustomerName, OrderID, OrderDate
    Task: List all customers from the USA who placed orders in the year 2023.
    Tables Used: Customers, Orders
	select CONCAT (FirstName, LastName )as customername, OrderID, OrderDate, country='USA' from orders as o join Customers as c on o.CustomerID=c.CustomerID 
	where year(orderdate)=2023 
    Return: CustomerName, TotalOrders
    Task: Show how many orders each customer has placed.
    Tables Used: Orders , Customers
	select concat(FirstName, LastName) as CustomerName, COUNT(OrderID)as TotalOrders from orders as o join customers as c on o.CustomerID=c.CustomerID 
	group by c.CustomerID, FirstName, LastName 
    Return: ProductName, SupplierName
    Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
    Tables Used: Products, Suppliers
	select ProductName, SupplierName from Suppliers as s join Products as p on s.SupplierID=p.SupplierID 
	where SupplierName = ('Gadget Supplies')
    Return: CustomerName, MostRecentOrderDate
    Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
    Tables Used: Customers, Orders
	select concat(FirstName, LastName)as CustomerName,  max(OrderDate) as MostRecentOrderDate from Orders as o left join Customers as c on o.CustomerID=c.CustomerID 
	group by FirstName, LastName, OrderDate
🟠 Medium-Level Tasks (6)

    Return: CustomerName, OrderTotal
    Task: Show the customers who have placed an order where the total amount is greater than 500.
    Tables Used: Orders, Customers
	select CONCAT(FirstName,LastName)as CustomerName, sum(TotalAmount) as OrderTotal from orders as o join customers as c on o.CustomerID=c.CustomerID 
	where TotalAmount >500
	group by FirstName, LastName
    Return: ProductName, SaleDate, SaleAmount
    Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
    Tables Used: Products, Sales
	select ProductName, SaleDate, SaleAmount from sales as s join Products as p on s.ProductID=p.ProductID 
	where  SaleAmount>500
    Return: ProductName, TotalSalesAmount
    Task: Display each product along with the total amount it has been sold for.
    Tables Used: Sales, Products
	select ProductName, sum(SaleAmount ) as  TotalSalesAmount from sales as s join Products as p on s.ProductID=p.ProductID 
	group by ProductName, SaleAmount 
    Return: EmployeeName, DepartmentName, Salary
    Task: Show the employees who work in the HR department and earn a salary greater than 60000.
    Tables Used: Employees, Departments
	select Name, DepartmentName, salary from Employees as e join Departments as d on e.DepartmentID=d.DepartmentID
	where  DepartmentName='Human Resources'	
    Return: ProductName, SaleDate, StockQuantity
    Task: List the products that were sold in 2023 and had more than 100 units in stock at the time.
    Tables Used: Products, Sales
	select ProductName, SaleDate, StockQuantity from Sales as s join Products as p on s.ProductID=p.ProductID 
	where StockQuantity>100
    Return: EmployeeName, DepartmentName, HireDate
    Task: Show employees who either work in the Sales department or were hired after 2020.
    Tables Used: Employees, Departments
	select Name, DepartmentName, HireDate from Employees as e join Departments as d on e.DepartmentID=d.DepartmentID 
	where DepartmentName='Sales'or year(HireDate)>2020
🔴 Hard-Level Tasks (7)

    Return: CustomerName, OrderID, Address, OrderDate
    Task: List all orders made by customers in the USA whose address starts with 4 digits.
    Tables Used: Customers, Orders
	SELECT c.name , o.OrderID, c.Address, o.OrderDate
	FROM Customers c
	JOIN Orders o ON c.id  = o.CustomerID
	WHERE c.Country = 'USA' 
	AND c.Address REGEXP '^[0-9]{4}';
    Return: ProductName, Category, SaleAmount
    Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
    Tables Used: Products, Sales
	select ProductName, Category, SaleAmount from sales as s join Products as p on s.ProductID=p.ProductID 
	where Category='Electronics' 
    Return: CategoryName, ProductCount
    Task: Show the number of products available in each category.
    Tables Used: Products, Categories
	SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
	FROM Categories c
	LEFT JOIN Products p ON c.CategoryID = p.CategoryID
	GROUP BY c.CategoryName;
	Return: CustomerName, City, OrderID, Amount
    Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
    Tables Used: Customers, Orders
	SELECT c.CustomerName, c.City, o.OrderID, o.Amount
	FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
	WHERE c.City = 'Los Angeles' 
	AND o.Amount > 300;
    Return: EmployeeName, DepartmentName
    Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
    Tables Used: Employees, Departments
	SELECT e.EmployeeName, d.DepartmentName
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE d.DepartmentName IN ('HR', 'Finance')
	OR (
    LENGTH(e.EmployeeName) - 
    LENGTH(REPLACE(LOWER(e.EmployeeName), 'a', '')) + 
    LENGTH(e.EmployeeName) - 
    LENGTH(REPLACE(LOWER(e.EmployeeName), 'e', '')) + 
    LENGTH(e.EmployeeName) - 
    LENGTH(REPLACE(LOWER(e.EmployeeName), 'i', '')) + 
    LENGTH(e.EmployeeName) - 
    LENGTH(REPLACE(LOWER(e.EmployeeName), 'o', '')) + 
    LENGTH(e.EmployeeName) - 
    LENGTH(REPLACE(LOWER(e.EmployeeName), 'u', '')) >= 4
	);
    Return: EmployeeName, DepartmentName, Salary
    Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
    Tables Used: Employees, Departments
	SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
AND e.Salary > 60000;
