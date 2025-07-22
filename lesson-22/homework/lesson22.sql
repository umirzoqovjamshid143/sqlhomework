1 Compute Running Total Sales per Customer
select customer_id, order_date,total_amount, sum(total_amount) over (partition by customer_id order by order_date
rows between unbounded preceding and current row ) as running_total_sales from sales_data;

2 Count the Number of Orders per Product Category

select distinct customer_id,customer_name, order_date,product_name,
count( product_name) over(PARTITION BY customer_name) 
as mahsulot_name from sales_data

3 Find the Maximum Total Amount per Product Category

select product_name sum(quantity_sold*unit_price)as max_totalamount group by product_name from sales_data
order by max_totalamount desc limit 1

4 Find the Minimum Price of Products per Product Category

select product_category,min(unit_price)as min_uunitprice from sales_data group by product_category

5 Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

select order_date,total_amount,round(avg(total_amount) over (
order by order_date rows between 1 PRECEDING and 1 following), 2) as moving_avg_3days from sales_data order by order_date;

6 Find the Total Sales per Region

select region ,sum(total_amount) as region_totalamount from sales_data group by region 

7 Compute the Rank of Customers Based on Their Total Purchase Amount

select customer_id,customer_name,sum(total_amount) as total_purchase,rank() over (order by sum(total_amount) desc) as purchase_rank
from sales_data group by customer_id, customer_name order by purchase_rank;

8 Calculate the Difference Between Current and Previous Sale Amount per Customer

select customer_id,order_date,total_amount,total_amount,lag(total_amount) over (partition by customer_idorder by order_date) as diff_from_prev_sale
from sales_dataorder by customer_id, order_date;

9 Find the Top 3 Most Expensive Products in Each Category

select *from (select product_category,product_name,unit_price rank() over (partition by product_category order by unit_price desc ) as price_rank
from sales_data) AS ranked_products where price_rank <= 3 order by product_category, price_rank;

10 Compute the Cumulative Sum of Sales Per Region by Order Date

select s1.region,s1.order_date,s1.total_amount,( select sum(s2.total_amount)from sales_data s2
where s2.region = s1.region and s2.order_date <= s1.order_date) as cumulative_sales
from sales_data s1 order by s1.region, s1.order_date;

11 Compute Cumulative Revenue per Product Category

select id, sum(ID) over (order by ID rows between unbounded preceding and current row) as SumPreValues from your_table;

12 Here you need to find out the sum of previous values. Please go through the sample input and expected output.

select ID, sum(ID) over (order by ID) as SumPreValues from your_table;

13 Sum of Previous Values to Current Value

select Value,sum(Value) over ( order by Value rows between UNBOUNDED PRECEDING and CURRENT ROW) as "Sum of Previous" from OneColumn;

14 Find customers who have purchased items from more than one product_category

select customer_id,customer_name,count(distinct product_category) as categoryproduct from sales_data group by customer_id,customer_name
having count(distinct product_category) > 1;

15 Find Customers with Above-Average Spending in Their Region
select*from sales_data
WITH RegionalAvg AS (SELect region, AVG(total_amount) AS avg_spending FROM sales_data GROUP BY region
)

SELECT 
    s.customer_id,
    s.customer_name,
    s.region,
    SUM(s.total_amount) AS total_spent
FROM sales_data s
GROUP BY s.customer_id, s.customer_name, s.region
HAVING SUM(s.total_amount) > (
    SELECT avg_spending 
    FROM RegionalAvg r 
    WHERE r.region = s.region);

16 Rank customers based on their total spending (total_amount) within each region. If multiple customers have the same spending, they should receive the same rank.

select  s.customer_id,s.customer_name,s.region,sum(s.total_amount) as total_spent from sales_data s
group by s.customer_id, s.customer_name, s.region having sum(s.total_amount) > ( select avg_spending from RegionalAvg r  where r.region = s.region);

17 Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.

select  customer_id,order_date, total_amount,sum(total_amount) over ( partition by customer_id order by order_date
rows between UNBOUNDED PRECEDING and current row ) as cumulative_sales from sales_data order by customer_id, order_date

18 Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
 
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS year_month,
        SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY year_month
)
SELECT 
    curr.year_month,
    curr.total_sales,
    prev.total_sales AS previous_month_sales,
    CASE 
        WHEN prev.total_sales IS NULL THEN NULL
        ELSE ROUND(
            ((curr.total_sales - prev.total_sales) / prev.total_sales) * 100, 2
        )
    END AS growth_rate_percent
FROM MonthlySales curr
LEFT JOIN MonthlySales prev
    ON prev.year_month = DATE_FORMAT(DATE_SUB(STR_TO_DATE(CONCAT(curr.year_month, '-01'), '%Y-%m-%d'), INTERVAL 1 MONTH), '%Y-%m')
ORDER BY curr.year_month;


19 Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)

with LastOrder as ( select customer_id,total_amount AS last_order_amount,order_date,row_number() over (partition by customer_id order by order_date desc) as rn
from sales_data),
CustomerTotals as ( select customer_id,sum(total_amount) as total_spent from sales_data group by customer_id)
select  ct.customer_id, ct.total_spent, lo.last_order_amount from CustomerTotals ct join LastOrder lo on ct.customer_id = lo.customer_id AND lo.rn = 1
where ct.total_spent > lo.last_order_amount;

20 Identify Products that prices are above the average product price
select*from sales_data

select product_name,unit_price from sales_data where unit_price>( select sum(unit_price)  from sales_data )


21 In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column.
The challenge here is to do this in a single select. For more details please see the sample input and expected output.

select  Id, Grp,Val1,Val2,case 
WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)  ELSE NULL END AS Tot FROM MyData;

22 Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values
.Please go through the sample input and expected output for details.

select Id, sum(Cost) as Cost,sum(Quantity) as Quantity from TheSumPuzzle group by Id, Quantity

23 From following set of integers, write an SQL statement to determine the expected outputs

WITH OrderedSeats AS (
    SELECT
        SeatNumber,
        LAG(SeatNumber) OVER (ORDER BY SeatNumber) AS PrevSeat
    FROM Seats
),
Gaps AS (
    SELECT
        PrevSeat + 1 AS GapStart,
        SeatNumber - 1 AS GapEnd
    FROM OrderedSeats
    WHERE PrevSeat IS NOT NULL
      AND SeatNumber - PrevSeat > 1
),
StartGap AS (
    SELECT 1 AS GapStart, MIN(SeatNumber) - 1 AS GapEnd
    FROM Seats
    HAVING MIN(SeatNumber) > 1
)
SELECT GapStart, GapEnd FROM StartGap
WHERE GapEnd >= GapStart
UNION ALL
SELECT GapStart, GapEnd FROM Gaps
ORDER BY GapStart;

 
