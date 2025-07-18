
1. Retrieve employees who earn the minimum salary in the company.Tables: employees (columns: id, name, salary)

select min(salary)from employees

2.Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)

select*from products where price>(select avg(price) from products)

3.Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department.Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)

select e.* from employees e  JOIN departments d on e.employeeid = d.departmentid
WHERE d.departmentname = 'Sales';

4.Task: Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)

select c.*from customers c left join orders o on c.customerid=o.orderid 
where o.orderid is null

5.Find Products with Max Price in Each CategoryTask: Retrieve products with the highest price in each category.Tables: products (columns: id, product_name, price, category_id)

 select category, max(price) from  products group by category  

6. Find Employees in Department with Highest Average Salary
Task: Retrieve employees working in the department with the highest average salary.
Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

select e.id, e.name, e.salary, e.department_id, d.department_name from employees e join (select department_id from employees group by department_id
 order by avg(salary) desc LIMIT 1) as top_dept on e.department_id = top_dept.department_idjoin departments d on e.department_id = d.id;

7. Find Employees Earning Above Department Average
Task: Retrieve employees earning more than the average salary in their department. 

SELECT e.id, e.name, e.salary, e.id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE id = e.id
);


8. Find Students with Highest Grade per Course
Task: Retrieve students who received the highest grade in each course.
Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)

select s.student_id, s.name, g.course_id, g.grade from grades g
join students s ON g.student_id = s.student_id where (g.course_id  g.grade) IN ( select course_id, MAX(grade) from grades group by course_id)



9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products (columns: id, product_name, price, category_id)

select id, product_name, price, category_id from ( select *,
 dense_rank() over (partition by category_id order by price desc) as rank from products) ranked_products
where rank = 3;


10.Find Employees whose Salary Between Company Average and Department Max Salary
Task: Retrieve employees with salaries above the company average but below the maximum in their department. Tables: employees (columns: id, name, salary, department_id)

select e.id, e.name, e.salary, e.department_id from employees e where e.salary > ( select avg(salary) from employees) AND e.salary < (
select max(salary)from employees d where d.department_id = e.department_id);
