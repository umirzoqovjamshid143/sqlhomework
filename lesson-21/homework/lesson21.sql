

1 Write a query to assign a row number to each sale based on the SaleDate.
select  *, ROW_NUMBER() over (order by SaleDate) as RowNum from productSales;

2 Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers.
select  ProductName, sum(Quantity) as TotalQuantitySold, DENSE_RANK() over (order by sum(Quantity) desc) as Rank from  ProductSales
group  by  ProductName;
3 Write a query to identify the top sale for each customer based on the SaleAmount.
select  lower(ProductName) as productname, SaleAmount as saleamount, SaleDate as saledate, CustomerID as customerid
from ProductSales ps
where SaleAmount = (select max(SaleAmount)from ProductSalesWHERE CustomerID = ps.CustomerID);

4 Write a query to display each sales amount along with the next sale amount in the order of SaleDate.
select SaleID,ProductName,SaleDate,SaleAmount,lead(SaleAmount) over (order by SaleDate) as NextSaleAmount from 
 ProductSales order by  SaleDate;

5 Write a query to display each sales amount along with the previous sale amount in the order of SaleDate.
select SaleID, ProductName, SaleDate, SaleAmount, lag(SaleAmount) over (order by SaleDate) as PreviousSaleAmount
from  ProductSales order by SaleDate;

6 Write a query to identify sales amounts that are greater than the previous sales amount
with WithLag as (select SaleID, ProductName, SaleDate, SaleAmount, lag(SaleAmount) over (order by SaleDate) as PreviousSaleAmount
 from ProductSales)select *from WithLag where SaleAmount > PreviousSaleAmount order by SaleDate;

7 Write a query to calculate the difference in sale amount from the previous sale for every product
select  SaleID,ProductName,SaleDate,SaleAmount,lag(SaleAmount) over (partition by ProductName order by SaleDate) as PreviousSaleAmount,
SaleAmount - lag(SaleAmount) over(partition by ProductName order by SaleDate) as AmountDifference from  ProductSales order by  ProductName, SaleDate;


8 Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
select  SaleID, ProductName, SaleDate, SaleAmount, lead(SaleAmount) over (order by SaleDate) as NextSaleAmount,
round((lead(SaleAmount) over (order by SaleDate) - SaleAmount) * 100.0 / SaleAmount,2 ) as PercentageChange
from  ProductSales order by SaleDate;

9 Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
SELECT SaleID,ProductName,SaleDate,SaleAmount,lag(SaleAmount) over (partition by ProductName order by SaleDate) as PreviousSaleAmount,
round(SaleAmount * 1.0 / lag(SaleAmount) over (partition by ProductName order by SaleDate),2 ) as SaleRatio
from ProductSales order by ProductName, SaleDate;

10 Write a query to calculate the difference in sale amount from the very first sale of that product.
select SaleID,ProductName,SaleDate,SaleAmount,
FIRST_VALUE(SaleAmount) over (partition by ProductName order by SaleDate) as FirstSaleAmount,
SaleAmount - FIRST_VALUE(SaleAmount) over (partition by ProductName order by SaleDate) as DifferenceFromFirst
from ProductSales order by  ProductName, SaleDate;


11 Write a query to find sales that have been increasing continuously for a product
(i.e., each sale amount is greater than the previous sale amount for that product).

with SalesWithLag as (select SaleID, ProductName, SaleDate,SaleAmount,
lag(SaleAmount) over (partition by ProductName order by SaleDate) as PreviousSaleAmount from ProductSales)
select *from SalesWithLag where SaleAmount > PreviousSaleAmount order by ProductName, SaleDate;

12 Write a query to calculate a "closing balance"(running total) for sales amounts which adds
the current sale amount to a running total of previous sales.
select SaleID,ProductName,SaleDate,SaleAmount,sum(SaleAmount) over (order by SaleDate rows BETWEEN unbounded PRECEDING and current row) as ClosingBalance
from ProductSales order by SaleDate;


13 Write a query to calculate the moving average of sales amounts over the last 3 sales.
select SaleID, ProductName,SaleDate, SaleAmount, round( avg(SaleAmount) over (order by SaleDate
rows between 2 PRECEDING and current row), 2) as MovingAvgLast3Sales from ProductSales order by SaleDate;

14 Write a query to show the difference between each sale amount and the average sale amount.

select SaleID, ProductName, SaleDate, SaleAmount, round(SaleAmount - avg(SaleAmount) over (),2) as DifferenceFromAverage
from ProductSales order by SaleDate;

15 Find Employees Who Have the Same Salary Rank

WITH SalaryRanks AS (
  SELECT 
    EmployeeID,
    FullName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
  FROM Employees
),
Duplicates AS (
  SELECT SalaryRank
  FROM SalaryRanks
  GROUP BY SalaryRank
  HAVING COUNT(*) > 1
)
SELECT s.*
FROM SalaryRanks s
JOIN Duplicates d ON s.SalaryRank = d.SalaryRank
ORDER BY s.SalaryRank, s.FullName;





16 Identify the Top 2 Highest Salaries in Each Department
select*from Employees1
select name, Department,hiredate,salary from (select name, Department,hiredate,salary,dense_rank() over(partition by department ORDER BY salary DESC  ) 
as rnk from  employees) as ranked where rnk <= 2;

17 Find the Lowest-Paid Employee in Each Department
select department, name, salary from  ( select department, name, salary, rank() over (partition by department order by salary asc)
as rank from employees1) as ranked where rank = 1

18 Calculate the Running Total of Salaries in Each Department

select name, Department,hiredate,salary,sum(salary) over(partition by department order by name) as runingtotal from employees1 

19 Find the Total Salary of Each Department Without GROUP BY

select name, Department,hiredate,salary,sum(salary) over(partition by department ) as totalsalary from employees1



20 Calculate the Average Salary in Each Department Without GROUP BY

select *,avg(salary) over(partition by department) as runningtotal from employees1

21 Find the Difference Between an Employees Salary and Their Departments Average

select name, Department,hiredate,salary, avg(salary) over(partition by department) as departeverege  from employees1
select avg(salary) over(partition by department) as everegdepart from employees1


22 Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

select name,department,hiredate,salary,round(avg(Salary) over ( order by EmployeeID  rows between 1 PRECEDING and 1 following ), 2) as MovingAvgSalary
from Employees1;

23 Find the Sum of Salaries for the Last 3 Hired Employees

SELECT SUM(salary) AS SumOfLast3Salaries
FROM (
  SELECT TOP 3 salary 
  FROM Employees1
  ORDER BY hiredate DESC
) AS Last3;







