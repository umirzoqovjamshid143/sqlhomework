
Creates a temp table #EmployeeBonus
Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
(BonusAmount = Salary * BonusPercentage / 100)
Then, selects all data from the temp table.

CREATE PROCEDURE GetEmployeeBonuses AS BEGIN
CREATE TABLE #EmployeeBonus (EmployeeID INT, FullName NVARCHAR(101), Department NVARCHAR(50), Salary DECIMAL(10,2),BonusAmount DECIMAL(10,2) );
INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)SELECT  e.EmployeeID, e.FirstName + ' ' + e.LastName AS FullName,
 e.Department, e.Salary, e.Salary * db.BonusPercentage / 100 AS BonusAmount FROM Employees e INNER JOIN 
 DepartmentBonus db ON e.Department = db.Department;
 SELECT * FROM #EmployeeBonus END;

 Task 2:
Create a stored procedure that:
Accepts a department name and an increase percentage as parameters
Update salary of all employees in the given department by the given percentage
Returns updated employees from that department.

CREATE PROCEDURE UpdateDepartmentSalaries  @DepartmentName NVARCHAR(50)  @IncreasePercentage DECIMAL(5,2)AS BEGIN
 UPDATE Employees SET Salary = Salary + (Salary * @IncreasePercentage / 100) WHERE Department = @DepartmentName;
   SELECT  EmployeeID, FirstName, LastName, Department, Salary FROM Employees WHERE Department = @DepartmentName;END;

   Task 3:
Perform a MERGE operation that:

Updates ProductName and Price if ProductID matches
Inserts new products if ProductID does not exist
Deletes products from Products_Current if they are missing in Products_New
Return the final state of Products_Current after the MERGE.

MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID WHEN MATCHED THEN UPDATE SET 
 target.ProductName = source.ProductName,
 target.Price = source.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;


task 4;
Tree Node

Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.

SELECT t1.id,CASE  WHEN t1.p_id IS NULL THEN 'Root' WHEN t1.id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
 ELSE 'Leaf'END AS type FROM Tree t1;

 Task 5:
Confirmation Rate

Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.

 SELECT s.user_id ROUND(
 IFNULL(SUM(c.action = 'confirmed') / COUNT(c.user_id), 0)
    , 2) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c ON s.user_id = c.user_id
GROUP BY 
    s.user_id;

Task 6:
Find employees with the lowest salary

	SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);
 task 7;
Create a stored procedure called GetProductSalesSummary that:

Accepts a @ProductID input
Returns:
ProductName
Total Quantity Sold
Total Sales Amount (Quantity × Price)
First Sale Date
Last Sale Date
If the product has no sales, return NULL for quantity, total amount, first date, and last date, but still return the product name.


CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM 
        Products p
    LEFT JOIN 
        Sales s ON p.ProductID = s.ProductID
    WHERE 
        p.ProductID = @ProductID
    GROUP BY 
        p.ProductName;
END;




