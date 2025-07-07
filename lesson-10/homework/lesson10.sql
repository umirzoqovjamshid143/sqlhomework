
    Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
    🔁 Expected Columns: EmployeeName, Salary, DepartmentName
	select Name, Salary, DepartmentName from Employees as e inner join departments as d on e.DepartmentID=d.DepartmentID 
	where salary > 5000
    Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
    🔁 Expected Columns: FirstName, LastName, OrderDate
	 select FirstName, LastName, OrderDate from Customers as c inner join Orders as o on c.CustomerID=o.CustomerID  
    Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
    🔁 Expected Columns: EmployeeName, DepartmentName
	select  Name, DepartmentName from Employees as e left join Departments as d on e.DepartmentID=d.DepartmentID 
    Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
    🔁 Expected Columns: SupplierName, ProductName
	select SupplierName, ProductName from Suppliers as s left join Products as p on p.ProductName=s.SupplierName 
    Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
    🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
	select o.OrderID,  o.OrderDate, p.PaymentDate, p.Amount from Orders as o left join Payments as p  on o.OrderID = p.OrderID
    Using the Employees table, write a query to show each employee's name along with the name of their manager.
    🔁 Expected Columns: EmployeeName, ManagerName
	select e.Name AS EmployeeName, m.Name AS ManagerName from employees as e  left join Employees as m  on e.ManagerID = m.EmployeeID 
    Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
    🔁 Expected Columns: StudentName, CourseName
	select s.name, c.CourseName from Students as s join Enrollments as e on s.StudentID=e.StudentID 
	inner join Courses as c on e.CourseID = c.CourseID where c.CourseName = 'Math 101'
    Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
    🔁 Expected Columns: FirstName, LastName, Quantity
	select FirstName, LastName, Quantity from Orders as o join Customers as c  on o.CustomerID=c.CustomerID 
	where o.Quantity > 3
    Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
    🔁 Expected Columns: EmployeeName, DepartmentName
	select Name, DepartmentName  from Employees as e join Departments as d on e.DepartmentID=d.DepartmentID 
	where DepartmentName='Human Resources'
🟠 Medium-Level Tasks (9)

    Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.
    🔁 Expected Columns: DepartmentName, EmployeeCount
	SELECT d.DepartmentName,COUNT(e.EmployeeID) AS EmployeeCount FROM Departments d inner JOIN Employees e ON d.DepartmentID = e.DepartmentID
	GROUP BY d.DepartmentName
	HAVING COUNT(e.EmployeeID) > 5
    Using the Products and Sales tables, write a query to find products that have never been sold.
    🔁 Expected Columns: ProductID, ProductName
	select s.saleID, ProductName from Products as p left join sales as s on p.ProductID=s.ProductID 
	where s.ProductID IS NULL
    Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
    🔁 Expected Columns: FirstName, LastName, TotalOrders
	select FirstName, LastName, Quantity   from Customers as c join Orders as o on c.CustomerID=o.CustomerID 
	where o.Quantity >= 1 
	order by o.Quantity 
    Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
    🔁 Expected Columns: EmployeeName, DepartmentName
	 select Name, DepartmentName from Departments as d join Employees as e on d.DepartmentID=e.DepartmentID 
    Using the Employees table, write a query to find pairs of employees who report to the same manager.
    🔁 Expected Columns: Employee1, Employee2, ManagerID
	 select e1.name as Employee1,  e2.name as  Employee2, e1.ManagerID  from employees as e1 join Employees as e2 on e1.ManagerID=e2.ManagerID 
	 where  e1.EmployeeID < e2.EmployeeID
    Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
    🔁 Expected Columns: OrderID, OrderDate, FirstName, LastName
	select  OrderID, OrderDate, FirstName, LastName from Customers as c join Orders as o on c.CustomerID=o.CustomerID 
	where year(o.OrderDate) = 2022
    Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
    🔁 Expected Columns: EmployeeName, Salary, DepartmentName
	  select Name, Salary, DepartmentName from Employees as e join Departments as d on e.DepartmentID=d.DepartmentID 
	  where Salary>60000
    Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
    🔁 Expected Columns: OrderID, OrderDate, PaymentDate, Amount
	select  OrderDate, PaymentDate, Amount from Payments as p join Orders as o on p.OrderID=o.OrderID 
    Using the Products and Orders tables, write a query to find products that were never ordered.
    🔁 Expected Columns: ProductID, ProductName
	select p.ProductID,  ProductName from Products as p left join Orders as o on p.ProductID=o.ProductID 
	where  o.ProductID IS NULL
🔴 Hard-Level Tasks (9)

    Using the Employees table, write a query to find employees whose salary is greater than the average salary in their own departments.
    🔁 Expected Columns: EmployeeName, Salary
	SELECT Name,Salary from  Employees as  e JOIN ( select DepartmentID, AVG(Salary) as avgsalary from Employees 
	group by DepartmentID) as d_avg on e.DepartmentID=d_avg.DepartmentID 
	where e.Salary > d_avg.AvgSalary
    Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
    🔁 Expected Columns: OrderID, OrderDate
	select OrderDate from Orders as o  join Payments as p on o.OrderID=p.OrderID 
	where year(PaymentDate) <=2022
    Using the Products and Categories tables, write a query to return products that do not have a matching category.
    🔁 Expected Columns: ProductID, ProductName
		SELECT p.ProductID, p.ProductName
	FROM Products p
	LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
	WHERE c.CategoryID IS NULL
    Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
    🔁 Expected Columns: Employee1, Employee2, ManagerID, Salary
	SELECT 
    e1.EmployeeID AS Employee1, 
    e2.EmployeeID AS Employee2, 
    e1.ManagerID, 
    e1.Salary
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID 
    AND e1.EmployeeID < e2.EmployeeID
WHERE e1.Salary > 60000 
    AND e2.Salary > 60000
    Using the Employees and Departments tables, write a query to return employees who work in departments which name starts with the letter 'M'.
    🔁 Expected Columns: EmployeeName, DepartmentName
	SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';
    Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
    🔁 Expected Columns: SaleID, ProductName, SaleAmount
	SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;
    Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
    🔁 Expected Columns: StudentID, StudentName
	SELECT s.StudentID, s.StudentName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID AND c.CourseName = 'Math 101'
WHERE c.CourseID IS NULL
    Using the Orders and Payments tables, write a query to return orders that are missing payment details.
    🔁 Expected Columns: OrderID, OrderDate, PaymentID
	SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL
    Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
    🔁 Expected Columns: ProductID, ProductName, CategoryName
	SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture')
