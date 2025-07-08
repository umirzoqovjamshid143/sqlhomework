Jamshid, [07/07/2025 20:40]
Create a numbers table using a recursive query from 1 to 1000.
WITH NumbersCTE AS ( SELECT 1 AS Number  UNION ALL
 SELECT Number + 1 FROM NumbersCTE WHERE Number < 1000)

Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select  e.EmployeeID, e.FirstName, e.LastName, sales_summary.TotalSales from   Employees e join  (
 select   EmployeeID,  sum(SalesAmount) as TotalSales from Sales group by  EmployeeID) as sales_summary on e.EmployeeID = sales_summary.EmployeeID order by e.EmployeeID;

Create a CTE to find the average salary of employees.(Employees)
with AvgSalaryCTE as ( select avg(Salary) as AverageSalary from Employees)
select AverageSalary from AvgSalaryCTE;

Write a query using a derived table to find the highest sales for each product.(Sales, Products)
select p.ProductID, p.ProductName, max_sales.MaxSalesAmount from Products p
join ( select  ProductID,max(SalesAmount) as MaxSalesAmount from  Sales group by ProductID) as max_sales on p.ProductID = max_sales.ProductID order by p.ProductID;

Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
with RecursiveDoubles as ( select 1 as Number union all select Number * 2 from RecursiveDoubles where Number * 2 < 1000000)
select Number from RecursiveDoubles order by Number;

Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
with SalesCountCTE as ( select  EmployeeID, count(*) as SalesCount from Sales group by  EmployeeID having  count(*) > 5)
select  e.EmployeeID, e.FirstName, e.LastName, sc.SalesCount from  Employees e join  SalesCountCTE sc on e.EmployeeID = sc.EmployeeID
order by  sc.SalesCount desc;

Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
with ProductSales as (select  ProductID,sum(SalesAmount) as TotalSales from Sales group  by ProductID)
select  p.ProductID, p.ProductName, ps.TotalSales from ProductSales ps join Products p on p.ProductID = ps.ProductID where ps.TotalSales > 500;

Create a CTE to find employees with salaries above the average salary.(Employees)
with AvgSalaryCTE AS ( select avg(Salary) as AvgSalary from Employees)
select  EmployeeID,FirstName,LastName, Salary from Employees, AvgSalaryCTE where Salary > AvgSalaryCTE.AvgSalary;


Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
select  e.EmployeeID, e.FirstName,e.LastName, OrderCounts.TotalOrders from Employees e JOIN (
 select EmployeeID, count(*) as TotalOrders from Sales group by EmployeeID) as OrderCounts on e.EmployeeID = OrderCounts.EmployeeID
order by OrderCounts.TotalOrders desc LIMIT 5;

Write a query using a derived table to find the sales per product category.(Sales, Products)
select p.CategoryID,SUM(sp.TotalSales) AS TotalSalesPerCategory FROM Products p JOIN ( select  ProductID, sum(SalesAmount) as TotalSales from Sales
 group  by ProductID) as sp on p.ProductID = sp.ProductID group by p.CategoryID order by TotalSalesPerCategory desc;


Write a script to return the factorial of each value next to it.(Numbers1)
 select  Number, 1 AS Counter CAST(1 AS BIGINT) AS Factorial FROM Numbers1
 UNION ALL
 SELECT  f.Number,f.Counter + 1,f.Factorial * (f.Counter + 1) FROM FactorialCTE f WHERE f.Counter < f.Number)
 SELECT  Number, MAX(Factorial) AS Faktorial FROM FactorialCTE GROUP BY Number ORDER BY Number;



This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
WITH CharSplitter AS ( SELECT Id, 1 AS Position, SUBSTRING(String, 1, 1) AS Character, String FROM Example WHERE LEN(String) > 0
 UNION ALL
 SELECT  cs.Id, cs.Position + 1, SUBSTRING(cs.String, cs.Position + 1, 1), cs.String FROM CharSplitter cs WHERE cs.Position < LEN(cs.String))
SELECT Id, Character FROM CharSplitter ORDER BY Id, Position;

Jamshid, [07/07/2025 20:40]
Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH MonthlySales AS ( SELECT  FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY FORMAT(SaleDate, 'yyyy-MM')),
SalesWithDiff AS ( SELECT  m1.SaleMonth, m1.TotalSales, LAG(m1.TotalSales) OVER (ORDER BY m1.SaleMonth) AS PreviousMonthSales FROM MonthlySales m1)
SELECT  SaleMonth,TotalSales, PreviousMonthSales, TotalSales - ISNULL(PreviousMonthSales, 0) AS SalesDifference FROM SalesWithDiff ORDER BY SaleMonth;


Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT E.EmployeeID, E.FirstName, E.LastName, SalesByQuarter.Quarter, SalesByQuarter.TotalSales FROM Employees E INNER JOIN
 (SELECT EmployeeID, DATEPART(QUARTER, SaleDate) AS Quarter,SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
 HAVING SUM(SalesAmount) > 45000 ) AS SalesByQuarter ON E.EmployeeID = SalesByQuarter.EmployeeID ORDER BY E.EmployeeID, SalesByQuarter.Quarter;

 This script uses recursion to calculate Fibonacci numbers
 CREATE FUNCTION dbo.Fibonacci(@n INT) RETURNS INT AS BEGIN
    IF @n = 0 RETURN 0;
    IF @n = 1 RETURN 1;
RETURN dbo.Fibonacci(@n - 1) + dbo.Fibonacci(@n - 2);END; GO

Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *FROM FindSameCharacters WHERE Vals IS NOT NULL
AND LEN(Vals) > 1 AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;


Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
WITH NumbersCTE AS ( SELECT 1 AS Num, CAST('1' AS VARCHAR(MAX)) AS NumSequence
 UNION ALL
SELECT Num + 1, CAST(NumSequence + CAST(Num + 1 AS VARCHAR) AS VARCHAR(MAX))  FROM NumbersCTE WHERE Num < @n)
SELECT Num, NumSequence FROM NumbersCTE OPTION (MAXRECURSION 1000);

Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT E.EmployeeID, E.FirstName, E.LastName, SalesSummary.TotalSales FROM Employees E
INNER JOIN
( SELECT EmployeeID, SUM(SalesAmount) AS TotalSales FROM Sales WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE()) GROUP BY EmployeeID) AS SalesSummary ON E.EmployeeID = SalesSummary.EmployeeID
WHERE SalesSummary.TotalSales = (SELECT MAX(TotalSales)FROM
( SELECT SUM(SalesAmount) AS TotalSales FROM Sales WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE()) GROUP BY EmployeeID) AS MaxSales );

Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
WITH ExtractedNumbers AS ( SELECT PawanName, Pawan_slug_name,
  RIGHT(Pawan_slug_name, CHARINDEX('-', REVERSE(Pawan_slug_name)) - 1) AS NumbersPart FROM RemoveDuplicateIntsFromNames),
Processed AS (SELECT  PawanName, Pawan_slug_name, NumbersPart, LEN( REPLACE( NumbersPart '0', '')  ) AS TotalDigits, 
 LEN( REPLACE(REPLACE(NumbersPart,'0', '' ),'1', '' )) AS AfterRemoveOneDigit  FROM ExtractedNumbers
)
SELECT 
    PawanName,
    Pawan_slug_name,
    CASE 
        WHEN LEN(NumbersPart) = 1 THEN 
           
            LEFT(Pawan_slug_name, LEN(Pawan_slug_name) - LEN(NumbersPart))
        ELSE
           
            CASE
                WHEN NumbersPart NOT LIKE '%[^' + LEFT(NumbersPart,1) + ']%' THEN 
                    LEFT(Pawan_slug_name, LEN(Pawan_slug_name) - LEN(NumbersPart))
                ELSE
                    
                    Pawan_slug_name
            END
    END AS CleanedName
FROM ExtractedNumbers;
