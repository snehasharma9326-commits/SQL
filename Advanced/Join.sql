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