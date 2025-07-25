
1 You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table
SELECT CAST(employee_id AS VARCHAR(10)) + '-' + first_name + ' ' + last_name AS employee_info
FROM employees;

2 Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999');


3That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees first names.(Employees)
SELECT 
    first_name AS [First Name], 
    LEN(first_name) AS [Name Length]
FROM employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'M%'
ORDER BY first_name;


4 Write an SQL query to find the total salary for each manager ID.(Employees table)
SELECT manager_id, SUM(salary) AS total_salary
FROM employees
GROUP BY manager_id;

5 Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
SELECT 
    year,
    (CASE 
        WHEN Max1 >= Max2 AND Max1 >= Max3 THEN Max1
        WHEN Max2 >= Max1 AND Max2 >= Max3 THEN Max2
        ELSE Max3
    END) AS highest_value
FROM TestMax;

6 Find me odd numbered movies and description is not boring.(cinema)
SELECT *
FROM cinema
WHERE movie_id % 2 = 1
  AND description NOT LIKE '%boring%';

7 You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;
8 Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
SELECT COALESCE(col1, col2, col3) AS first_non_null
FROM person;

9 Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT 
    LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName,
    RIGHT(FullName, CHARINDEX(' ', REVERSE(FullName)) - 1) AS LastName,
    LTRIM(RTRIM(SUBSTRING(
        FullName,
        CHARINDEX(' ', FullName) + 1,
        LEN(FullName) - CHARINDEX(' ', FullName) - CHARINDEX(' ', REVERSE(FullName))
    ))) AS MiddleName
FROM Students;
10 For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
SELECT o.*
FROM Orders o
WHERE o.customer_id IN (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE delivery_state = 'California'
)
AND o.delivery_state = 'Texas';
11 Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT STRING_AGG(value_column, ', ') AS concatenated_values
FROM DMLTable;
12 Find all employees whose names (concatenated first and last) contain the letter "a" at least 3 times.
SELECT *
FROM employees
WHERE LEN(first_name + last_name) - LEN(REPLACE(first_name + last_name, 'a', '')) >= 3;

13 The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
SELECT 
    department_id,
    COUNT(*) AS total_employees,
    CAST(SUM(CASE WHEN DATEDIFF(year, hire_date, GETDATE()) > 3 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS percent_over_3_years
FROM employees
GROUP BY department_id
14 Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)

SELECT TOP 1 spaceman_id, job_description, experience_years
FROM Personal
ORDER BY experience_years DESC;


SELECT TOP 1 spaceman_id, job_description, experience_years
FROM Personal
ORDER BY experience_years ASC;

15 Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
DECLARE @str NVARCHAR(100) = 'tf56sd#%OqH';

SELECT
    -- Katta harflar
    (
      SELECT STRING_AGG(SUBSTRING(@str, number, 1), '') WITHIN GROUP (ORDER BY number)
      FROM master..spt_values
      WHERE type = 'P' AND number BETWEEN 1 AND LEN(@str)
      AND SUBSTRING(@str, number, 1) LIKE '[A-Z]'
    ) AS UppercaseLetters,

    -- Kichik harflar
    (
      SELECT STRING_AGG(SUBSTRING(@str, number, 1), '') WITHIN GROUP (ORDER BY number)
      FROM master..spt_values
      WHERE type = 'P' AND number BETWEEN 1 AND LEN(@str)
      AND SUBSTRING(@str, number, 1) LIKE '[a-z]'
    ) AS LowercaseLetters,

    -- Raqamlar
    (
      SELECT STRING_AGG(SUBSTRING(@str, number, 1), '') WITHIN GROUP (ORDER BY number)
      FROM master..spt_values
      WHERE type = 'P' AND number BETWEEN 1 AND LEN(@str)
      AND SUBSTRING(@str, number, 1) LIKE '[0-9]'
    ) AS Numbers,

    -- Boshqa belgilar
    (
      SELECT STRING_AGG(SUBSTRING(@str, number, 1), '') WITHIN GROUP (ORDER BY number)
      FROM master..spt_values
      WHERE type = 'P' AND number BETWEEN 1 AND LEN(@str)
      AND SUBSTRING(@str, number, 1) NOT LIKE '[A-Za-z0-9]'
    ) AS OtherChars;
16 Write an SQL query that replaces each row with the sum of its value and the previous rows value. (Students table)
SELECT
    id,
    value,
    SUM(value) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM Students
ORDER BY id;

17 You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
DECLARE @equation NVARCHAR(4000) = '2 + 3 * 4'; -- example equation
DECLARE @sql NVARCHAR(MAX);
DECLARE @result FLOAT;

SET @sql = 'SELECT @result_out = ' + @equation;

EXEC sp_executesql @sql, N'@result_out FLOAT OUTPUT', @result_out = @result OUTPUT;

SELECT @result AS CalculatedResult;
18 Given the following dataset, find the students that share the same birthday.(Student Table)
SELECT 
    s1.*
FROM Student s1
JOIN Student s2
    ON s1.birthdate = s2.birthdate
    AND s1.student_id <> s2.student_id
ORDER BY s1.birthdate;
19 You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
    CASE WHEN playerA < playerB THEN playerA ELSE playerB END AS Player1,
    CASE WHEN playerA < playerB THEN playerB ELSE playerA END AS Player2,
    SUM(score) AS TotalScore
FROM PlayerScores
GROUP BY 
    CASE WHEN playerA < playerB THEN playerA ELSE playerB END,
    CASE WHEN playerA < playerB THEN playerB ELSE playerA END;



























