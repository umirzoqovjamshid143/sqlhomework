1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)

select  Id,
    ltrim(rtrim(substring(Name, 1, charindex(',', Name) - 1))) as FirstName,
    ltrim(rtrim(substring(Name, charindex(',', Name) + 1, len(Name)))) as LastName from  dbo.TestMultipleColumns;



2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
select *from TestPercent where Strs like '%\%%' escape '\'

3.In this puzzle you will have to split a string based on dot(.).(Splitter)
select Id, value as Ajratilgan_qiymat
from Splitter
cross apply string_split(Vals, '.');

4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
select  Id, MyText as OriginalText,
  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    MyText, '0', 'X'), '1', 'X'), '2', 'X'), '3', 'X'), '4', 'X'),'5', 'X'), '6', 'X'), '7', 'X'), '8', 'X'), '9', 'X') as ReplacedText from MyTable;


5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)

select*from testdots
where len(Vals) - len(replace(Vals, '.', '')) > 2;

6.Write a SQL query to count the spaces present in the string.(CountSpaces)

select texts,length(texts)-length(replace(texts,' ','')) as kod from countspaces

7.write a SQL query that finds out employees who earn more than their managers.(Employee)

select e.name as EmployeeName, e.Salary as EmployeeSalary,
       m.Name as ManagerName, m.Salary as ManagerSalary from Employee e join Employee m on e.ManagerId = m.Id where e.Salary > m.Salary;

8.Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)

select EmployeeID,FirstName,LastName,HireDate,
timestampdiff(year, HireDate, curdate()) as YearsOfService from Employees where timestampdiff(year, HireDate, curdate()) > 10 AND
timestampdiff(year, HireDate, curdate()) < 15;


9.Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)

select mixed_string, REGEXP_REPLACE(mixed_string, '[^0-9]', '') as digits, REGEXP_REPLACE(mixed_string, '[0-9]', '') as letters from mixed_data;


10.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)

select w1.id from weather w1 join weather w2 on w1.id = dateadd(day, 1, w2.id) 
where w1.temperature > w2.temperature;

11.Write an SQL query that reports the first login date for each player.(Activity)

select  player_id,  min(games_played) as first_login_date from  Activity group by  player_id;

12.Your task is to return the third item from that list.(fruits)
with split as (select  fruit_list, value = trim(value), rn = row_number() ever (partition by fruit_list order by (select null))
from  fruits cross apply string_split(fruit_list, ','))
select value as third_fruit from split where rn = 3;

13.Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
SELECT
  val,
  -- Keep only letters
  (SELECT '' + SUBSTRING(val, v.number, 1)
   FROM master.dbo.spt_values v
   WHERE v.number BETWEEN 1 AND LEN(val)
     AND SUBSTRING(val, v.number, 1) LIKE '[A-Za-z]'
   FOR XML PATH('')) AS characters,

  -- Keep only digits
  (SELECT '' + SUBSTRING(val, v.number, 1)
   FROM master.dbo.spt_values v
   WHERE v.number BETWEEN 1 AND LEN(val)
     AND SUBSTRING(val, v.number, 1) LIKE '[0-9]'
   FOR XML PATH('')) AS digits
FROM 
  your_table;

14.You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)

select  p1.id, case  when p1.code = 0 then p2.code else p1.code end as final_code from   p1 join p2 on p1.id = p2.id

15.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
If the employee has worked for less than 1 year → 'New Hire'
If the employee has worked for 1 to 5 years → 'Junior'
If the employee has worked for 5 to 10 years → 'Mid-Level'
If the employee has worked for 10 to 20 years → 'Senior'
If the employee has worked for more than 20 years → 'Veteran'(Employees)
select  employee_id, name, hire_date, case
when datediff(year, hire_date, getdate()) < 1 then 'New Hire'  when datediff(year, hire_date, getdate()) between 1 and 5 THEN 'Junior'
when datediff(year, hire_date, getdate()) between 6 AND 10 THEN 'Mid-Level' when datediff(year, hire_date, getdate()) between 11 and 20 THEN 'Senior'
 else 'Veteran' end as employment_stage from employees;


16.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)

select  Vals, cast(left(Vals, patindex('%[^0-9]%', Vals + 'X') - 1) as int) as extracted_integer from  GetIntegers where  Vals LIKE '[0-9]%';

17.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)

SELECT STRING_AGG( CASE  WHEN LENGTH(word) >= 2 THEN 
SUBSTRING(word FROM 2 FOR 1) || SUBSTRING(word FROM 1 FOR 1) || SUBSTRING(word FROM 3)  Else      word
        END,
        ','
    ) AS swapped_string
FROM (
    SELECT 
        unnest(string_to_array(val_string, ',')) AS word
    FROM 
        MultipleVals
) AS words;


18.Write a SQL query that reports the device that is first logged in for each player.(Activity)

select player_id, device_id, games_played
from (select player_id, device_id, games_played, row_number() over (partition by player_id order by games_played) as rn from activity) sub
where rn = 1;

19.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
select area,
 extract(year from sales_date) as sales_year,
 extract(week from sales_date) as sales_week,
    sales_date,
    sales_amount,
    round(100.0 * sales_amount / sum(sales_amount) over (partition by area, extract(year from sales_date), extract(week from sales_date)), 2) as percentage_of_week
from sales order by area sales_year, sales_week, sales_date;
