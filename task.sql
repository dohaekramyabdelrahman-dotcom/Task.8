--Create a new database named "CompanyDB."
create database CompanyDB
--Create a schema named "Sales" within the "CompanyDB" database.
go
create schema Sales_
go
use CompanyDB
--sequence for id 
create sequence i
start with 1 
increment by 1  

--Create a table named "employees" with columns: employee_id (INT) - use sequence instead of identity,first_name (VARCHAR),last_name (VARCHAR),salary (DECIMAL)
create table Sales_.Employees
(
 employee_id int primary key DEFAULT (NEXT VALUE FOR i),
 first_name varchar(50),
 last_name varchar(50),
 salary decimal
)
--Alter the "employees" table to add a new column named "hire_date" with the data type DATE.
alter table Sales_.Employees
add hire_date date 
--Select all columns from the "Employees" table.
select * 
from Sales_.Employees
--Select only the "Name" and "Salary" columns from the "Employees" table
select first_name , last_name ,salary
from Sales_.Employees
--Select the top 5 records from the "Employees" table.
select top (5) *
from Sales_.Employees
--Select all records from the "Employees" table, ordered by the "Salary" column in descending order.//List employees with salaries in descending order.
select *
from Sales_.Employees
order by salary desc
--Select the first 10 records from the "Employees" table, starting from the third record.
select *
from Sales_.Employees
order by employee_id
offset 2 rows 
fetch next 10 rows only 
--Select the average salary from the "Employees" table.//--Show the average salary of all employees. (Use AVG() function)
select avg(salary) Average_salary
from Sales_.Employees
--Select the maximum and minimum salaries from the "Employees" table.
select min(salary) minimum , max(salary) maximum
from Sales_.Employees
--Select the top 3 highest salaries from the "Employees" table.
select top (3) salary
from Sales_.Employees
order by salary desc
--Select all records from the "Employees" table, ordered by "Name" in ascending order.
select * 
from Sales_.Employees
order by first_name ,last_name ASC 
--Select the first 5 records from the "Employees" table, starting from the second record, ordered by "Salary" in descending order.
select *
from Sales_.Employees
order by salary desc
offset 1 rows 
fetch next 5 rows only 
--Select the sum of all salaries from the "Employees" table. (search on it)
select sum(salary)
from Sales_.Employees
--Select all columns from the "employees" table.
select * 
from Sales_.Employees
----Find employees with salaries between 40000 and 60000.
select *
from Sales_.Employees
where salary between 40000 and 60000
--Retrieve only the "first_name" and "last_name" columns from the "employees" table.
select first_name , last_name
from Sales_.Employees
--Select employees whose salary is greater than 50000.
select *
from Sales_.Employees
where salary > 50000
--Retrieve employees hired in the year 2020.//--Retrieve employees hired between '2020-01-01' and '2021-01-01'.
select *
from Sales_.Employees
where [hire_date] >= '2020-01-01' and [hire_date] < '2021-01-01'
--List employees whose last names start with 'S'
select *
from Sales_.Employees
where last_name like 's%'
--Display the top 10 highest-paid employees.
select top (10)  *
from Sales_.Employees
order by salary desc
--Find employees with salaries between 40000 and 60000.
select *
from Sales_.Employees
where salary between 40000 and 60000
--Show employees with names containing the substring 'man'.
select *
from Sales_.Employees
where first_name like '%man%' or last_name like '%man%'
--Display employees with a NULL value in the "hire_date" column.
select *
from Sales_.Employees
where [hire_date] is null
--Select employees with a salary in the set (40000, 45000, 50000).
select *
from Sales_.Employees
where salary in (40000 , 45000 , 50000)
--Show the first 5 employees ordered by "last_name" in ascending order.
select *
from Sales_.Employees
order by last_name asc
offset 0 rows 
fetch next 5 rows only 
--Display employees with a salary greater than 55000 and hired in 2020.
select *
from Sales_.Employees
where salary >55000 and [hire_date] >= '2020-01-01' and [hire_date] < '2021-01-01'
--select employees whose first name is 'John' or 'Jane'.
select *
from Sales_.Employees
where first_name= 'jhon' or  first_name = 'jane'
--List employees with a salary ≤ 55000 and a hire date after '2022-01-01'.
select *
from Sales_.Employees
where salary <=55000 and  [hire_date] > '2022-01-01'
--Retrieve employees with a salary greater than the average salary.
SELECT *
FROM Sales_.Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Sales_.Employees
)
--Select records from the "Employees" table where the "Salary" is between 40000 and 60000, ordered by "Salary" in ascending order.
select *
from Sales_.Employees
where salary between 40000 and 60000
order by salary asc
--Display the 3rd to 7th highest-paid employees. (Use OFFSET and FETCH)
select *
from Sales_.Employees
order by salary desc
offset 2 rows 
fetch next 5 rows only 
--List employees hired after '2021-01-01' in alphabetical order.
select *
from Sales_.Employees
where [hire_date] > '2021-01-01' 
order by first_name asc
--Retrieve employees with a salary > 50000 and last name not starting with 'A'.
select *
from Sales_.Employees
where salary>50000 and last_name not like 'a%'
--Display employees with a salary that is not NULL.
select *
from Sales_.Employees
where salary is not null
--Show employees with names containing 'e' or 'i' and a salary > 45000.
select *
from Sales_.Employees
where (first_name+last_name like '%e%'or first_name+last_name like '%i%') and salary>45000
----------------------------------------JOIN-RELATED EXERCISES-------------------------------------------
--Create a new table named "departments" with columns:department_id (Primary Key, INT),department_name (VARCHAR),manager_id (INT, references "employees".employee_id).
create table Sales_.departments
(
 department_id int primary key,
 department_name varchar(50),
 manager_id int references [Sales_].[Employees]([employee_id])
)
--Assign each employee to a department by creating a "department_id" column in "employees" and making it a foreign key referencing "departments".department_id.
alter table [Sales_].[Employees]
add department_id int 
alter table [Sales_].[Employees]
add constraint fk_depart foreign key (department_id) references [Sales_].[departments] (department_id)
INSERT INTO Sales_.Departments
(department_id, department_name, manager_id)
VALUES
(1, 'IT', NULL),
(2, 'HR', NULL),
(3, 'Sales', NULL),
(4, 'Marketing', NULL);
UPDATE Sales_.Employees
SET department_id = 1
WHERE employee_id IN (1, 2, 3);

UPDATE Sales_.Employees
SET department_id = 2
WHERE employee_id IN (4, 5);

UPDATE Sales_.Employees
SET department_id = 3
WHERE employee_id IN (6, 7);

UPDATE Sales_.Employees
SET department_id = 4
WHERE employee_id IN (8, 9, 10);
--Retrieve all employees with their department names (Use INNER JOIN).
select se.*  , sd.[department_name]
from [Sales_].[Employees] se
inner join [Sales_].[departments] sd
on se.[department_id] = sd.[department_id]
--Retrieve employees who don’t belong to any department (Use LEFT JOIN and check for NULL).
select *
from [Sales_].[Employees] se
left join [Sales_].[departments] sd
on se.[department_id] = sd.[department_id]
WHERE sd.department_id IS NULL
--Show all departments and their employee count (Use JOIN and GROUP BY).
select COUNT(employee_id) ,department_name,sd.department_id
from [Sales_].[Employees] se
left join [Sales_].[departments] sd
on se.[department_id] = sd.[department_id]
group by sd.department_id, sd.department_name
--Retrieve the highest-paid employee in each department (Use JOIN and MAX(salary)).
select se.employee_id,se.first_name,se.last_name,se.salary,sd.department_name
from [Sales_].[Employees] se
inner join [Sales_].[departments] sd
on se.[department_id] = sd.[department_id]
where se.salary = (
    select max(e.salary)
    from Sales_.Employees e
    where e.department_id = se.department_id
    )
    ----------------------------part1------------------------------------------
   -- create a table Employees with columns: Id, FirstName, LastName, Salary.
   create table Employees
   (
   id int primary key,
   FirstName varchar(50),
   LastName varchar(50),
   Salary decimal
   )
   --Create a stored procedure named GetAllEmployees that selects all rows from Employees.
   create procedure GetAllEmployees
   as 
   begin 
   select * from Employees
   end 
   --Create a stored procedure GetHighSalaryEmployees with one input parameter @MinSalary which Select all employees with Salary > @MinSalary
   create  procedure GetHighSalaryEmployees(@MinSalary decimal)
   as
   begin 
   select * from Employees where Salary > @Minsalary 
   end 
   --Create AddEmployee SP with @FirstName, @LastName, @Salary which Insert a new row into Employees. 
   create procedure AddEmployee (@FirstName varchar(50),@LastName varchar(50),@Salary decimal)
   as 
   begin 
   insert into Employees (FirstName, LastName, Salary)
   values (@FirstName, @LastName, @Salary)
   end 
   ------------------------------part2------------------------------------
   --Create a table EmployeeLog(Id, EmployeeId, Action, ActionDate).
   create table EmployeeLog
   (
   id int primary key ,
   EmployeeId int ,
    Action varchar(50),
    ActionDate datetime
    )
    --create AFTER INSERT Trigger which Automatically log when a new employee is added.
    create trigger after_insertEmployee
    on Employees
    after insert 
    as
    begin 
    insert into EmployeeLog(EmployeeId, Action, ActionDate)
    select  id, 'insert', getdate()
    from inserted
    end