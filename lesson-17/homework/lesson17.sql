1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
with cte as (
select distinct region from #regionsales as r1 ) ,cte2 as(select distinct distributor from #regionsales as r2)
select cte.region=cte2.regionsales, isnull(sales,0) as sales from cte cross join cte2 left join #regionsales as r3
on cte.region =r3.region and cte2.distributor=r3.distributor

2. Find managers with at least five direct reports
select e1.name from employee e1 join Employee e2 on e1.id=e2.managerID
group by e1.id, e1.name having count(*) >=5

3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

select products.product_name,sum(unit) from orders join products on orders.product_id=products.product_id
where year(order_data)=2020 and month(order_data)=2
group by products.product_name 
having sum(unit)>=100

4. Write an SQL statement that returns the vendor from which each customer has placed the most orders

with as (select customerID,vendor,sum(count) as total from orders group by customerID,Vendor),
cte2 as (select CustomerID,vendor , sum(count) as total from orders group by customerID,Vendor ),
cte3 as (select customerID, max(total) as total2 from cte group by customerID)
select*from cte2 join cte3 on cte2.customerID=cte3.customerID and cte3.total2=cte2.total 

5.You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

declare @Check_Prime int = 91;
declare @i int = 2;
declare @is_prime bit = 1;

if @Check_Prime <= 1 set @is_prime = 0;else begin while @i * @i <= @Check_Prime begin if @Check_Prime % @i = 0 begin set @is_prime = 0;  break;end
 set @i = @i + 1;  end end IF @is_prime = 1 PRINT 'This number is prime';
else
    print 'This number is not prime';

6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

with total_locations as (select count(distinct Locations) as number_of_locations from Device),
location_signals as ( select Locations, count(*) as signal_count from Device group by Locations),
top_location as (select Locations as most_signals_location, signal_count as most_signals_count
from location_signals order by signal_count desc LIMIT 1),
device_signals as (
    select Device_id, count(*) as total_signals from Device group by Device_id)
SELECT  ds.Device_id,  ds.total_signals, tl.number_of_locations, tlc.most_signals_location, tlc.most_signals_count FROM device_signals ds
cross join total_locations tl cross join top_location tlc;

7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output

select EmpID, EmpName, Salary from Employee e where Salary > ( select avg(Salary) from Employee where DeptID = e.DeptID)

8.You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.

with cte as (select case when count(*)=3 then 100 else 10 end as Prize from Tickets t join 
Numbers n on t.number=n.number group by TicketID) select sum(prize) from cte


9.The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.
Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

with user_platforms as (
    select   User_id,  Spend_date,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) as used_mobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) as  used_desktop,
        SUM(Amount) as total_amount
    from Spending
    GROUP BY User_id, Spend_date
),
labeled_users AS (
    select
        Spend_date,
        case
            when used_mobile = 1 AND used_desktop = 0 THEN 'Mobile Only'
            when used_mobile = 0 AND used_desktop = 1 THEN 'Desktop Only'
            when used_mobile = 1 AND used_desktop = 1 THEN 'Both'
        end as  platform_type,
        total_amount
    from user_platforms
)
select
    Spend_date,
    platform_type,
    count(*) as total_users,
    sum(total_amount) as total_amount_spent     from  labeled_users
group by Spend_date, platform_type
order by Spend_date, platform_type;

10. Write an SQL Statement to de-group the following data.

WITH RECURSIVE numbers AS (SELECT 1 AS n UNION ALL
 SELECT n + 1 FROM numbers WHERE n < 100)
SELECT  g.country
FROM
    GroupedData g
JOIN
    numbers n ON n.n <= g.total_people
ORDER BY
    g.country;


