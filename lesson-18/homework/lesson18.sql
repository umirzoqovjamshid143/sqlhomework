1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
Return: ProductID, TotalQuantity, TotalRevenue

select ProductID, sum(Quantity) over (partition by ProductID) as TotalQuantity, sum(Quantity * Price) over (partition by ProductID) as TotalRevenue
from Sales where month(OrderDate) = month(current_date()) and YEAR(OrderDate) = year(current_date());


2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
Return: ProductID, ProductName, Category, TotalQuantitySold
create view vw_ProductSalesSummary as 
select p.ProductID, p.ProductName, p.Category, sum(s.quantity)as totalprice  from products p
join sales s on p.ProductID=s.Saleid group by  p.ProductID, p.ProductName, p.Category


3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
Return: total revenue for the given product ID

create view fn_GetTotalRevenueForProduct(@ProductID INT) returns decimal(18,2)as begin
declare @TotalRevenue decimal(18,2); select  @TotalRevenue = sum(p.Price * s.Quantity)from  Sales s
inner join Products p on s.ProductID = p.ProductID where  p.ProductID = @ProductID;
 return isnull(@TotalRevenue, 0) END;

4. Create an function fn_GetSalesByCategory(@Category varchar(50))
Return: ProductName, TotalQuantity, TotalRevenue for all products in that category

select distinct p.Productname, sum(s.quantity) over(partition by  p.Productid ) as totalM
Sum(s.quantity*p.price) over(partition by  p.Productid) as totalM2 from  products p 
left join sales s on p.ProductID = s.ProductID where p.Category = @Category;

5. You have to create a function that get one argument as input from user and the function should return 'Yes' if the input number is a prime number and 'No' otherwise. You can start it like this:

Create function dbo.fn_IsPrime (@Number INT)
Returns ...
This is for those who has no idea about prime numbers: A prime number is a number greater than 1 that has only two divisors: 1 and itself(2, 3, 5, 7 and so on).

create view dbo.fn_IsPrime (@Number INT) returns varchar(3)AS function begin
 if @Number <= 1 return 'No';
if @Number = 2  return 'Yes'if @Number % 2 = 0 return 'No';
declare @i int = 3; declare @sqrt int = floor(sqrt(@Number)); while @i <= @sqrt begin if @Number % @i = 0
 return 'No';
 set @i = @i + 2;  -- Check only odd divisors
  end return 'Yes';
end;

6. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input:
It should include all integer values from @Start to @End, inclusive.

create function fn_GetNumbersBetween
( @Start int, @End int)
returns table as return
( with NumbersCTE as ( select @Start as Number where @Start <= @End union all select Number + 1 from NumbersCTE where Number + 1 <= @End

7.Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.

create function getNthHighestSalary(@n INT)
returns int
as
begin declare @result int;
select @result = ( select distinct salary from Employee order by salary desc OFFSET (@n - 1) rows fetch next 1 row ONLY )
 return @result; end;

 8. Write a SQL query to find the person who has the most friends.
Return: Their id, The total number of friends they have

Friendship is mutual. For example, if user A sends a request to user B and its accepted, both A and B are considered friends with each other. The test case is guaranteed to have only one user with the most friends.
Input.RequestAccepted table:

 WITH AllFriends AS (
    SELECT requester_id AS user_id, accepter_id AS friend_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id, requester_id AS friend_id FROM RequestAccepted),
FriendCounts AS (SELECT user_id, COUNT(DISTINCT friend_id) AS num FROM AllFriends GROUP BY user_id),
MaxFriends AS (
    SELECT MAX(num) AS max_num FROM FriendCounts)
SELECT user_id AS id, num
FROM FriendCounts
WHERE num = (SELECT max_num FROM MaxFriends);


9.Create a View for Customer Order Summary.Create a view called vw_CustomerOrderSummary that returns a summary of customer orders. The view must contain the following columns:

create view vw_CustomerOrderSummary as select  c.customer_id, c.name,
 count(o.order_id) as total_orders,  COALESCE(SUM(o.amount), 0) AS total_amount, max(o.order_date) AS last_order_date from Customers c
left join  Orders o on c.customer_id = o.customer_id group by  c.customer_id, c.name;


10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
select  RowNumber, max(TestCase) over (order by RowNumber rows between unbounded preceding and current row) as Workflow from Gaps
order br RowNumber;                                       

