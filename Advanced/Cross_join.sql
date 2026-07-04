# Create the database
CREATE DATABASE join_1;
USE join_1;


create table employees (
    emp_id int,
    emp_name varchar(50),
    dept_id int,
    salary int
);

create table departments (
    dept_id int,
    dept_name varchar(50)
);

insert into employees values
(1, 'Amit', 101, 50000),
(2, 'Priya', 102, 60000),
(3, 'Rahul', 101, 55000),
(4, 'Sneha', 103, 40000),
(5, 'Karan', NULL, 45000);

insert into departments values
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

#types of joins we have 

#inner join - output we will get is = matching records

#show rows where both tables have matching dept_id

select e.emp_name, d.dept_name
from employees e 
inner join departments d
on e.dept_id = d.dept_id ;

#Left Join

#all employees data and matching department name

select e.emp_name, d.dept_name
from employees e
left join departments d
on e.dept_id = d.dept_id;

#all dept_names and the employees working in those dept

select e.emp_name, d.dept_name 
from employees e 
right join departments d
on e.dept_id = d.dept_id;

#union 

select e.emp_name, d.dept_name
from employees e
left join departments d
on e.dept_id = d.dept_id

union

select e.emp_name, d.dept_name
from employees e
right join departments d
on e.dept_id = d.dept_id;

#join + where 

#emp_name who are working in IT dept 

#inner join + where

select e.emp_name,d.dept_name
from employees e
inner join departments d
on e.dept_id = d.dept_id
where d.dept_name = "IT";

#Join + group by

# employees by department

Select d.dept_name, count(e.emp_id) as total_emp
from employees e
 join departments d
on
e.dept_id = d.dept_id
group by d.dept_name;

#join + aggregations + group by 

#find the average salary in each dept 

select d.dept_name, avg(salary) as avg_salary
from employees e
join departments d
on e.dept_id = e.dept_id
group by d.dept_name;

#join + aggregations + group by + having 

#department have > 1 employee .

select d.dept_name, count(e.emp_id) as total_emp
from employees e
join departments d
on e.dept_id = d.dept_id
group by d.dept_name
having total_emp > 1;

#self join

create database selfjoin;

use selfjoin;

create table employees (
    emp_id int,
    emp_name varchar(50),
    manager_id int,
    salary int
);

insert into employees values
(1, 'Amit', NULL, 90000),
(2, 'Priya', 1, 60000),
(3, 'Rahul', 1, 55000),
(4, 'Sneha', 2, 40000),
(5, 'Karan', 2, 45000),
(6, 'Arjun', 3, 50000);

select * from employees;

select e.emp_name as employee, m.emp_name as manager
from employees e
left join employees m
on
e.manager_id = m.emp_id;

#only employees who have manager 

select e.emp_name as employee, m.emp_name as manager
from employees e
inner join employees m
on
e.manager_id = m.emp_id;

# count employees under each manager

#self join + group by

select m.emp_name as manager,count(e.emp_id) as total_emp
from employees e
join employees m
on e.manager_id = m.emp_id
group by m.emp_name;

#Find employees earning more than their manager

select e.emp_name as employee, e.salary, m.emp_name as manager, m.salary
from employees e 
join employees m 
on e.manager_id = m.emp_id
where e.salary > m.salary ;

# Manager with Highest team size

#Join + group by + order by 

select m.emp_name as manager,count(e.emp_id)
from employees e
join employees m
on 
e.manager_id = m.emp_id
group by m.emp_name
order by team_size desc
limit 1;

#Find top level manager how doesn't have any mmanager

select emp_name
from employees 
where "Manager_id: is Null";

select e.emp_name as employee,
m.emp_name as manager,
mm.emp_name as senior_manager
from employees e
left join employees m on e.manager_id = m.emp_id
left join employees mm on m.manager_id = mm.emp_id;

#cross joins

create database crossjoin;

use crossjoin;

create table employees (
    emp_id int,
    emp_name varchar(50)
);

insert into employees values
(1, 'Amit'),
(2, 'Priya'),
(3, 'Rahul');

create table departments (
    dept_id int,
    dept_name varchar(50)
);

insert into departments values
(101, 'HR'),
(102, 'IT');

#cross join = all combinations - # no matching condition - every row combines with every row
#employees - 3rows + departments - 2 rows ->Result = 3*2 = 6 rows

#Basic cross join -all rows - get duplicate entries

select e.emp_name , d.dept_name
from employees e
cross join departments d;

#cross join using comma

select e.emp_name, d.dept_name
from employees e , department d;

#cross join + where

select e.emp_name,d.dept_name
from employees e
cross join departments d
where d.dept_name = "IT";

#unique pairs only - remove duplicate pairs

select e1.emp_name , e2.emp_name
from employees e1
cross join employees e2
where e1.emp_id < e2.emp_id;

#cross join + group by - count of employees

select d.dept_name, count(e.emp_id) as total
from employees e
cross join departments d
group by d.dept_name;

#Sub Queries!
create database company_subquery;
use company_subquery;

create table departments (
    dept_id int,
    dept_name varchar(50)
);

create table employees (
    emp_id int,
    emp_name varchar(50),
    dept_id int,
    salary int
);

insert into employees values
(1, 'Amit', 101, 50000),
(2, 'Priya', 102, 60000),
(3, 'Rahul', 101, 55000),
(4, 'Sneha', 103, 40000),
(5, 'Karan', 102, 45000),
(6, 'Arjun', 103, 70000),
(7, 'Neha', NULL, 48000);

insert into departments values
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

#Find employees earning more than average salary

select emp_name , salary
from employees
where salary > (
select avg(salary) from employees );

# max - aggregation

#Find the highest paid employee
select emp_name, salary
from employees
where salary = (
select max(salary) from employees );

#find employees who is in IT department
select emp_name from employees
where dept_id in (
select dept_id from departments
where dept_name = "IT"); #inner query will get the ouput dept_id = 102

#subquery + Not in
#find the employees who is not in HR department

Select emp_name from
employees
where dept_id not in (
select dept_id
from departments 
where dept_name = "HR");

select emp_name, salary
from employees e
where salary >
( select avg(salary)
from employees 
where dept_id = e.dept_id);

#Employees earning more than any HR employee

select emp_name
from employees
where salary > any
(select salary 
from employees
where dept_id = 101);

#Nested subquery 


select emp_name
from employees
where dept_id = (
select dept_id
from departments
where dept_name = (
 select "IT")
 );
 
 #Important Rules
 # In Subquery - single value ( = )
 # in multiples values -) in
 #subqueries slow downs the extraction process - #inner query - find average and compare the outcome with others!

#Windows Function

#function_name() over (partition by column order by column)

# Row number ()

Select emp_name, salary,
row_number() over ( order by salary desc) as row_nums
from employees ;

# rank() - same salary - same rank - 1,2,2,4 -skip the number

select emp_name,salary,
rank() over (order by salary desc)
from employees ;

#Dense rank - ()

#there will be no gaps - 1,2,2,3,4

select emp_name,salary,
dense_rank() over (order by salary desc)
from employees ;

#Partition by
#rank within each department

select emp_name,dept_id,salary,
rank() over (partition by dept_id order by salary desc) as dept_rank
from employees ;

#Total salary per department 

select dept_id,
sum(salary) over (partition by dept_id) as dept_total
from employees;

select emp_name,salary,
sum(salary) over (order by emp_id) as running_total
from employees;

#avg salary per department 




#LAG - very imp

select emp_name, salary,
lag(salary) over( order by emp_id) as prev_salary
from employees;

#Lead
select emp_name,salary,
lead(salary) over (order by emp_id) as next_salary
from employees;

select * from
(select emp_name,salary,
rank() over ( order by salary desc) as rnk
from employees) m
where rnk = 1;

select emp_name, salary,
rank() over ( order by salary desc)
from employees;

# employees record with salary > 50000 and using rank

select emp_name, salary,
rank() over ( order by salary desc ) as rnk
from employees
where salary > 50000;

select dept_id, avg_sal,
rank() over (order by avg_sal desc ) as dept_rnk from
(select dept_id, avg(salary) as avg_sal
from employees 
group by dept_id) t;

select dept_id, avg_sal,
dense_rank() over (order by avg_sal desc ) as dept_rnk from
(select dept_id, avg(salary) as avg_sal
from employees 
group by dept_id) w;

select dept_id , avg_sal ,
rank() over (order by avg_sal desc ) as dept_rnk from
( select dept_id , avg(salary) as avg_sal 
from employees
group by dept_id 
having avg_sal > 50000) t ;

#windows + join + where 

# Rank employees in IT department based on salary

select e.emp_name,d.dept_name, e.salary,
rank() over ( order by salary desc) as rnk
from employees e
join departments d
on 
e.dept_id = d.dept_id
where d.dept_name = "IT";

#window + Group by + having - combo

#Top departments based on total salary(>100000) - rank

select dept_id, total_sal,
rank() over ( order by total_sal desc) as dept_rank from
(select dept_id, sum(salary) as total_sal
from employees
group by dept_id
having total_sal > 100000) t;

create database view1;

use view1;

create table employees (
emp_id int,
emp_name varchar(50),
department varchar(50),
job_role varchar(50),
salary int,
experience int,
city varchar(50),
joining_year int );


select * from employees;

#views -
# view is a virtual table where it doesn't store data , it stores


create view it_employees 
as
select *
from employees
where department = "IT";


select * from it_employees;

create view employee_basic as
select emp_name,department,salary
from employees;

select * from employee_basic;

create view high_sal
as
select *
from employees
where salary > 70000;

create view bonus_view as
select emp_name, salary ,salary * 0.10 as bonus 
from employees;

select * from bonus_view;

#view with aggregation

#department avg salary 

create view dep_avg_sal as
select department, avg(salary) as avg_salary 
from employees
group by department;

select * from dep_avg_sal;

#case statements
#IF-else

select emp_name,salary,
case
when salary > 70000 then "High"
else "Low"
end as salary_level
from employees;

#Multiple conditions - salary > 80k - very high,

select emp_name,salary,
case
when salary > 80000 then "very High"
when salary between 60000 and 80000 then "Medium"
else "Low"
end as category
from employees;

#Case with order by

select emp_name, department 
from employees
order by
case 
when department = "IT" then 1
when department = "HR" then 2
else 3
end;

select department,
sum(
case 
when salary > 70000 then 1
else 0
end) as high_paid_count
from employees
group by department;

use retail_db;


create table employees (
emp_id int primary key,
emp_name varchar(50) not null,
department varchar(50),
job_role varchar(50),
salary int check ( salary >  30000),
experience int,
city varchar(50),
joining_year int
);

insert into employees values
(16,'Rahul',"IT",'Developer',6200,3,'Delhi',2021);

select * from employees;

update the data 

update employees
set salary = 65000
where emp_id = 1;


update employees
set salary = 70000, city = 'Pune'
where emp_id = 2;


Delete from employees
where emp_id = 16;

Alter table employees
add email varchar(50);

Alter table employees
modify email varchar(100);

Alter table employees
drop column email;

#Temporary result set used inside query 

#Basic syntax

with emp_cte as (
select * from employees
)

select * from emp_cte;

#Filter CTE

with high_sal as (
select * from employees where salary > 70000
)
select * from high_sal;

#Aggregation CTE - dept wise avg salary

with dept_avg as (
select department, avg(salary) as avg_sal
from employees
group  by department)
select * from dept_avg;

#CTE + Joins

#Find each employees salary and compare it with their department's average salary

# Step 1 - dept wise avg - cte

select e.emp_name,e.salary,d.avg_sal
from employees e
join dept_avg d
on 
e.department = d.department;

with dept_avg as(
select department, avg(salary) as avg_sal
from employees
group by department)
select e.emp_name,e.salary,d.avg_sal
from employees e
join dept_avg d
on 
e.department = d.department;



create database E2E;

use E2E;


create table employees (
emp_id int primary key,
emp_name varchar(50) not null,
department varchar(50),
job_role varchar(50),
salary  int check ( salary > 30000),
experience int,
city varchar(50),


joining_year int
);















