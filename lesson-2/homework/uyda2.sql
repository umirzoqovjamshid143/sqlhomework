Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
create table Employees  (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10, 2));
Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
insert into Employees (EmpID, Name, Salary) VALUES
(1, 'JOHN', 12000),(2, 'MAYKL',14000),(3,'JOHON',22000);
Update the Salary of an employee to 7000 where EmpID = 1.
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1; 
Delete a record from the Employees table where EmpID = 2.
delete from employees where empID=2
Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
DELETE — jadvaldan ma’lum yozuvlarni o‘chiradi.
TRUNCATE — jadvaldagi barcha yozuvlarni tez o‘chiradi.
DROP — butun jadvalni (yoki boshqa ob’ektni) butunlay o‘chirib tashlaydi.
Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
Add a new column Department (VARCHAR(50)) to the Employees table.
Alter table Employees ADD Department Varchar(50)
Change the data type of the Salary column to FLOAT.
Alter table Employees
Alter column Salary FLOAT 
Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE TABLE Departments(departmentID INT primary key ,DepartmentName Varchar(50));
Remove all records from the Employees table without deleting its structure.
delete from Employees
Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
 Insert into Departmens (DepartmentID, DepartmentName, Location)
 (1,'IT', 'toshkent'),(2,'HR', 'Qarshi'),(3, 'merketing', 'Saqmarqand'),(4, 'Finance', 'shahrisabz'),(5, 'Operations', 'Andijan');
Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
Write a query that removes all employees but keeps the table structure intact.
DELETE FROM Employees;
Drop the Department column from the Employees table.
alter table Employees
drop column Department;
Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers';
Write a query to completely remove the Departments table from the database.
DROP TABLE Departments
Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT);
Add a CHECK constraint to ensure Price is always greater than 0.
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2) CHECK (Price > 0),
    StockQuantity INT);
Rename Category to ProductCategory
exec sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products (ProductID, ProductName, Price, Quantity)
values (1, 'Apple iPhone 14', 799.99, 50),(2, 'Samsung Galaxy S23', 699.99, 40),(3, 'Xiaomi Redmi Note 13', 299.99, 100),
(4, 'Google Pixel 8', 749.99, 30),(5, 'OnePlus 12', 649.99, 25);

Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT *
INTO Products_Backup
FROM Products;
Rename the Products table to Inventory.
exec sp_rename 'Products', 'Inventor';

Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
ALTER TABLE Inventory
ADD ProductCode INT;

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM Inventory
)
UPDATE CTE
SET ProductCode = 1000 + (rn - 1) * 5;
