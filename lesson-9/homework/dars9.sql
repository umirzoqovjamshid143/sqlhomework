

Using Products, Suppliers table List all combinations of product names and supplier names.
select products.productName, Suppliers.supplierName from products
cross join Suppliers
Using Departments, Employees table Get all combinations of departments and employees.
select departments.departmentName,Employees.Name from departments cross join Employees
Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
select products.productName,Suppliers.SupplierName from products cross join Suppliers
Using Orders, Customers table List customer names and their orders ID.
select orders.OrderID,customers.FirstName from Orders  join Customers Orders.CustomerID = Customers.CustomerID;
Using Courses, Students table Get all combinations of students and courses.
select courses.courseName,students.Name from Courses cross join students
Using Products, Orders table Get product names and orders where product IDs match.
select products.productName,Orders.OrderID from products join Orders ON Products.ProductID = Orders.ProductID;
Using Departments, Employees table List employees whose DepartmentID matches the department.
select departments.DepartmentName,employees.departmentName from departments join employees on departments.departmentID=employees.EmployeeID
Using Students, Enrollments table List student names and their enrolled course IDs.
select Students.StudentName, Enrollments.CourseID from Studentsjoin  Enrollments on Students.StudentID = Enrollments.StudentID;
Using Payments, Orders table List all orders that have matching payments.
select Orders.OrderID, Payments.PaymentID from Orders join Payments on Orders.OrderID = Payments.OrderID;
Using Orders, Products table Show orders where product price is more than 100.
select Orders.OrderID, Products.ProductName, Products.Price
from Orders join Products on Orders.ProductID = Products.ProductID where Products.Price > 100;
Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
select Employees.departmentName, Departments.DepartmentName
from Employees cross join Departments where Employees.employeeID <> Departments.DepartmentID;
Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.

select Orders.OrderID, Products.ProductName, Orders.Quantity, Products.StockQuantity from Orders  JOIN Products ON Orders.ProductID = Products.ProductID
WHERE Orders.Quantity > Products.StockQuantity;
Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
select customers.firstname,Sales.ProductID,Sales.SaleAmount from Sales join customers on 
Sales.CustomerID = Customers.CustomerID WHERE Sales.SaleAmount >= 500;
Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
select Students.StudentName, Courses.CourseName from  Students
join Enrollments on Students.StudentID = Enrollments.StudentID join Courses on Enrollments.CourseID = Courses.CourseID;
Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”
select Products.ProductName, Suppliers.SupplierName from Products
join Suppliers on Products.SupplierID = Suppliers.SupplierID where Suppliers.SupplierName LIKE '%Tech%';
Using Orders, Payments table Show orders where payment amount is less than total amount.
select Orders.OrderID, Orders.TotalAmount, Payments.PaymentAmount
from Orders
join Payments on Orders.OrderID = Payments.OrderID
where Payments.PaymentAmount < Orders.TotalAmount;
Using Employees and Departments tables, get the Department Name for each employee.
select Employees.EmployeeName, Departments.DepartmentName from Employees join Departments on Employees.DepartmentID = Departments.DepartmentID;
Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
select Products.ProductName, Categories.CategoryName from Products
join Categories on Products.CategoryID = Categories.CategoryID where Categories.CategoryName IN ('Electronics', 'Furniture');
Using Sales, Customers table Show all sales from customers who are from 'USA'.
select Sales.SaleID, Sales.ProductID, Sales.SaleAmount, Customers.CustomerName, Customers.Country
from Sales join Customers on Sales.CustomerID = Customers.CustomerID
where Customers.Country = 'USA';
Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
select Orders.OrderID, Customers.CustomerName, Orders.TotalAmount
from Orders
join Customers on Orders.CustomerID = Customers.CustomerID
where Customers.Country = 'Germany' and Orders.TotalAmount > 100;

Using Employees table List all pairs of employees from different departments.
SELECT 
    e1.employee_id AS employee1_id,
    e1.name AS employee1_name,
    e1.department_id AS dept1,
    e2.employee_id AS employee2_id,
    e2.name AS employee2_name,
    e2.department_id AS dept2
FROM Employees e1
JOIN Employees e2 ON e1.employee_id < e2.employee_id
WHERE e1.department_id != e2.department_id;

Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT 
    p.payment_id,
    p.order_id,
    p.amount_paid,
    o.quantity,
    pr.price,
    (o.quantity * pr.price) AS expected_amount
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN Products pr ON o.product_id = pr.product_id
WHERE p.amount_paid != (o.quantity * pr.price);
Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT s.student_id, s.student_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_id IS NULL;
Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
SELECT DISTINCT m.employee_id, m.name AS manager_name, m.salary AS manager_salary,  
e.employee_id AS employee_id, e.name AS employee_name, e.salary AS employee_salary from Employees m
join Employees e ON m.employee_id = e.manager_id where m.salary <= e.salary;
Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
select distinct c.customer_id, c.customer_name
from Customers c
join Orders o ON c.customer_id = o.customer_id
left join Payments p ON o.order_id = p.order_id
where p.order_id IS NULL;
