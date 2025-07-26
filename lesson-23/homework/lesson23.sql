-- 1
Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output.
SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

-- 2
Puzzle 2: In this puzzle you have to find out the unique Ids present in the table. You also have to find out the SUM of Max values of vals columns for each Id and RId. For more details please see the sample input and expected output.
SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxTable
GROUP BY rID;

-- 3
Puzzle 3: In this puzzle you have to get records with at least 6 characters and maximum 10 characters. Please see the sample input and expected output.
SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

-- 4
Puzzle 4 In this puzzle you have to find the maximum value for each Id and then get the Item for that Id and Maximum value. Please check out sample input and expected output.

SELECT ID, Item, Vals
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals DESC) AS rn
    FROM TestMaximum
) t
WHERE rn = 1;

-- 5
Puzzle 5: In this puzzle you have to first find the maximum value for each Id and DetailedNumber, and then Sum the data using Id only. Please check out sample input and expected output.
SELECT Id, SUM(MaxVal) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;

-- 6
Puzzle 6: In this puzzle you have to find difference between a and b column between each row and if the difference is not equal to 0 then show the difference i.e. a – b otherwise 0. Now you need to replace this zero with blank.Please check the sample input and the expected output
SELECT 
    Id,
    a,
    b,
    CASE WHEN a - b = 0 THEN '' ELSE CAST(a - b AS VARCHAR) END AS OUTPUT
FROM TheZeroPuzzle;

-- 7
7 What is the total revenue generated from all sales?
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;

-- 8
8 What is the average unit price of products?
SELECT AVG(UnitPrice) AS AvgUnitPrice FROM Sales;

-- 9 
9 How many sales transactions were recorded?
SELECT COUNT(*) AS TotalTransactions FROM Sales;

-- 10
What is the highest number of units sold in a single transaction?
SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;

-- 11
11 How many products were sold in each category?
SELECT Category, SUM(QuantitySold) AS TotalUnits FROM Sales GROUP BY Category;

-- 12
12 What is the total revenue for each region?
SELECT Region, SUM(QuantitySold * UnitPrice) AS Revenue FROM Sales GROUP BY Region;

-- 13
13 Which product generated the highest total revenue?
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Product
ORDER BY Revenue DESC;

-- 14
14 Compute the running total of revenue ordered by sale date.
SELECT 
    SaleID, 
    SaleDate, 
    Product, 
    QuantitySold * UnitPrice AS Revenue,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningRevenue
FROM Sales;

-- 15
15 How much does each category contribute to total sales revenue?

SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER() AS PercentageContribution
FROM Sales
GROUP BY Category;

-- 16
16 Show all sales along with the corresponding customer names
SELECT s.*, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

-- 17
17 List customers who have not made any purchases
SELECT *
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Sales s WHERE s.CustomerID = c.CustomerID
);

-- 18
18 Compute total revenue generated from each customer
SELECT CustomerID, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY CustomerID;

-- 19
19 Find the customer who has contributed the most revenue
SELECT TOP 1 CustomerID, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY CustomerID
ORDER BY Revenue DESC;

-- 20
20 Calculate the total sales per customer

SELECT CustomerID, COUNT(*) AS Transactions, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY CustomerID;

-- 21
21 List all products that have been sold at least once
SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;
-- 22
22 Find the most expensive product in the Products table
SELECT TOP 1 *
FROM Products
ORDER BY SellingPrice DESC;

-- 23
Find all products where the selling price is higher than the average selling price in their category
SELECT *
FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products p2
    WHERE p2.Category = p.Category
);
