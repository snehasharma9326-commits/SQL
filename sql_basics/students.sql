# Create database
create database school;

#use 
use school;

#create

create table students (
id int ,
name varchar(50),
age int,
city varchar(50),
marks float
);

# to get the output
select * 
from students;

# insert values into school
 
 insert into students ( name, age, city, marks) values
 ('Amit', 20, 'Mumbai', 85),
 ('Priya', 22, 'Delhi', 90),
 ('Rahul', 21, 'Mumbai', 72),
 ('Sneha', 23, 'Delhi', 60),
 ('karan', 20, 'Chennai', 95),
 ('Meena', 22, 'Mumbai', 55),
 ('Rohit', 24, "Delhi", 40),
 ('Anjali', 21, 'Chennai', 88);
 
 select * 
 from students;
 
 
 alter table students modify id int auto_increment primary key;
 
 # Selecting specific columns
 select name, marks
 from students;
 
 # select with column alias
 
 select name as Student_name,
 marks as Total_marks
 from students;
 
 # Where - Fetching students record stays in Mumbai
 
 select *
 from students
 where city = 'Mumbai';
 
 # numeric condition - fetch the students records who have scored > 80.
 
 select *
 from students
 where marks > 80;
 
 # And (Multiple Condition) - students stays in delhi and age > 20
 
 select *
 from students
 where city = 'Delhi' and age > 20;
 
 # OR
 select *
 from students
 where city = 'Delhi' or age > 20;
 
 # Not
  select *
  from students
  where not city = "Delhi";
  
  # Between - marks between 60-90 - RANGE
   select *
   from students
   where marks between 60 and 90 ;
   
   # Multiple values - students stays in mumbai, delhi
   
   select *
   from students
   where city in ('Mumbai' , 'Delhi');
   
   
   
   
   
  
 
 
 
 
 
 
 
 



